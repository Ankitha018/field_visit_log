import '../entities/visit.dart';

abstract class VisitRepository {
  Future<List<Visit>> getVisits();

  Future<void> createVisit(Visit visit);

  Future<void> updateVisit(Visit visit);

  Future<VisitStatus> syncVisit(Visit visit);
}