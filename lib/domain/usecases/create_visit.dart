import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class CreateVisit {
  const CreateVisit(this._repository);

  final VisitRepository _repository;

  Future<void> call(Visit visit) {
    return _repository.createVisit(visit);
  }
}