import '../../domain/entities/visit.dart';
import '../models/visit_model.dart';

class VisitMapper {
  const VisitMapper();

  VisitModel toModel(Visit visit) {
    return VisitModel(
      id: visit.id,
      date: visit.date,
      location: visit.location,
      note: visit.note,
      status: visit.status,
      createdAt: visit.createdAt,
      syncedAt: visit.syncedAt,
    );
  }

  Visit toEntity(VisitModel model) {
    return Visit(
      id: model.id,
      date: model.date,
      location: model.location,
      note: model.note,
      status: model.status,
      createdAt: model.createdAt,
      syncedAt: model.syncedAt,
    );
  }
}