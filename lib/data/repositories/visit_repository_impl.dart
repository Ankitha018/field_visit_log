import '../../core/errors/app_exception.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../datasources/visit_local_data_source.dart';
import '../datasources/visit_remote_data_source.dart';
import '../mappers/visit_mapper.dart';

class VisitRepositoryImpl
    implements VisitRepository {
  const VisitRepositoryImpl({
    required VisitLocalDataSource localDataSource,
    required VisitRemoteDataSource remoteDataSource,
    required VisitMapper mapper,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _mapper = mapper;

  final VisitLocalDataSource _localDataSource;
  final VisitRemoteDataSource _remoteDataSource;
  final VisitMapper _mapper;

  @override
  Future<List<Visit>> getVisits() async {
    final localVisits =
    await _localDataSource.getLocalVisits();

    final visitLog =
    await _localDataSource.getVisitLog();

    final allVisits = [
      ...localVisits,
      ...visitLog,
    ];

    allVisits.sort(
          (a, b) =>
          b.createdAt.compareTo(a.createdAt),
    );

    return allVisits
        .map(_mapper.toEntity)
        .toList();
  }

  @override
  Future<void> createVisit(
      Visit visit,
      ) async {
    final draft = visit.copyWith(
      status: VisitStatus.draft,
    );

    final model = _mapper.toModel(draft);

    await _localDataSource.insertLocalVisit(
      model,
    );
  }

  @override
  Future<void> updateVisit(
      Visit visit,
      ) async {
    final model = _mapper.toModel(visit);

    final exists =
    await _localDataSource.localVisitExists(
      visit.id,
    );

    if (exists) {
      await _localDataSource.insertLocalVisit(
        model,
      );
    } else {
      await _localDataSource.insertVisitLog(
        model,
      );
    }
  }

  @override
  Future<VisitStatus> syncVisit(
      Visit visit,
      ) async {
    try {
      final result =
      await _remoteDataSource.syncVisit();

      final status = _convertResult(result);

      final updatedVisit = visit.copyWith(
        status: status,
        syncedAt: status == VisitStatus.synced
            ? DateTime.now()
            : null,
      );

      final model =
      _mapper.toModel(updatedVisit);

      await _localDataSource.deleteLocalVisit(
        visit.id,
      );

      await _localDataSource.insertVisitLog(
        model,
      );

      return status;
    } catch (_) {
      throw const SyncException(
        message: 'Unable to sync visit.',
        code: 'SYNC_ERROR',
      );
    }
  }

  VisitStatus _convertResult(
      MockSyncResult result,
      ) {
    switch (result) {
      case MockSyncResult.synced:
        return VisitStatus.synced;
      case MockSyncResult.draft:
        return VisitStatus.draft;
      case MockSyncResult.failed:
        return VisitStatus.failed;
    }
  }
}