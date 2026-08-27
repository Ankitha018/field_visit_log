import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class UpdateVisit {
  const UpdateVisit(this._repository);

  final VisitRepository _repository;

  Future<void> call(Visit visit) {
    return _repository.updateVisit(visit);
  }
}