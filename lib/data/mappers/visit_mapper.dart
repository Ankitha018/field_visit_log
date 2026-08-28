import '../../domain/entities/visit.dart';
import '../models/visit_model.dart';

class VisitMapper {
  const VisitMapper();

  Visit toEntity(VisitModel model) {
    return model.toEntity();
  }

  VisitModel toModel(Visit entity) {
    return VisitModel.fromEntity(entity);
  }
}
