import '../entities/sync_result.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class SyncVisits {
  const SyncVisits(this._repository);

  final VisitRepository _repository;

  Future<SyncResult> call(Visit visit) {
    return _repository.syncVisit(visit);
  }
}
