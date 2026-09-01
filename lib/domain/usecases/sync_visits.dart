import '../entities/visit.dart';
import '../enums/visit_status.dart';
import '../repositories/visit_repository.dart';

class SyncVisits {
  const SyncVisits(this._repository);
  final VisitRepository _repository;
  Future<VisitStatus> call(Visit visit) {
    return _repository.syncVisit(visit);
  }
}
