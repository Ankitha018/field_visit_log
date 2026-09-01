import '../../core/errors/app_exception.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/sync_result.dart';
import '../../domain/entities/visit.dart';
import '../../domain/enums/visit_status.dart';
import '../../domain/repositories/visit_repository.dart';
import '../datasources/visit_local_data_source.dart';
import '../datasources/visit_remote_data_source.dart';
import '../mappers/visit_mapper.dart';

class VisitRepositoryImpl implements VisitRepository {
  const VisitRepositoryImpl({
    required VisitLocalDataSource localDataSource,
    required VisitRemoteDataSource remoteDataSource,
    required VisitMapper mapper,
    required ConnectivityService connectivityService,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _mapper = mapper,
       _connectivityService = connectivityService;

  final VisitLocalDataSource _localDataSource;
  final VisitRemoteDataSource _remoteDataSource;
  final VisitMapper _mapper;
  final ConnectivityService _connectivityService;

  @override
  Future<List<Visit>> getVisits() async {
    try {
      final localVisits = await _localDataSource.getLocalVisits();
      final visitLogs = await _localDataSource.getVisitLogs();

      final allVisits = [...localVisits, ...visitLogs];

      allVisits.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return allVisits.map(_mapper.toEntity).toList();
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to load visits.',
        code: 'GET_VISITS_ERROR',
      );
    }
  }

  @override
  Future<void> createVisit(Visit visit) async {
    try {
      final draft = visit.copyWith(status: VisitStatus.draft, syncedAt: null);

      final model = _mapper.toModel(draft);

      await _localDataSource.insertLocalVisit(model);
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to create visit.',
        code: 'CREATE_VISIT_ERROR',
      );
    }
  }

  @override
  Future<void> updateVisit(Visit visit) async {
    try {
      final model = _mapper.toModel(visit);

      final exists = await _localDataSource.localVisitExists(visit.id);

      if (exists) {
        await _localDataSource.insertLocalVisit(model);
      } else {
        await _localDataSource.insertVisitLog(model);
      }
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to update visit.',
        code: 'UPDATE_VISIT_ERROR',
      );
    }
  }

  @override
  Future<SyncResult> syncVisit(Visit visit) async {
    try {
      final connected = await _connectivityService.isConnected();

      // No internet connection.
      // Keep the visit locally as a draft.
      if (!connected) {
        final draft = visit.copyWith(status: VisitStatus.draft, syncedAt: null);

        final model = _mapper.toModel(draft);

        await _localDataSource.insertLocalVisit(model);

        return const SyncResult(status: VisitStatus.draft, wasOffline: true);
      }

      // Internet is available, so attempt synchronization.
      final result = await _remoteDataSource.syncVisit();

      final status = _convertResult(result);

      final updatedVisit = visit.copyWith(
        status: status,
        syncedAt: status == VisitStatus.synced ? DateTime.now() : null,
      );

      final model = _mapper.toModel(updatedVisit);

      if (status == VisitStatus.synced) {
        await _localDataSource.deleteLocalVisit(visit.id);
        await _localDataSource.insertVisitLog(model);
      } else {
        // Keep Draft/Failed visits locally.
        await _localDataSource.insertLocalVisit(model);
      }

      return SyncResult(status: status, wasOffline: false);
    } catch (_) {
      throw const SyncException(
        message: 'Unable to sync visit.',
        code: 'SYNC_ERROR',
      );
    }
  }

  VisitStatus _convertResult(MockSyncResult result) {
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
