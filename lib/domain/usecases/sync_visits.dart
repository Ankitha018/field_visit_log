import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class SyncVisits {
  const SyncVisits(this._repository);

  final VisitRepository _repository;

  Future<VisitStatus> call(Visit visit) {
    return _repository.syncVisit(visit);
  }
}