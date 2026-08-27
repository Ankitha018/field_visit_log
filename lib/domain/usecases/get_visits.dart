import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class GetVisits {
  const GetVisits(this._repository);

  final VisitRepository _repository;

  Future<List<Visit>> call() {
    return _repository.getVisits();
  }
}