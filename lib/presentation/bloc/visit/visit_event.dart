import '../../../domain/entities/visit.dart';

abstract class VisitEvent {
  const VisitEvent();
}

class LoadVisits extends VisitEvent {
  const LoadVisits();
}

class CreateVisitEvent extends VisitEvent {
  const CreateVisitEvent({required this.visit});

  final Visit visit;
}

class UpdateVisitEvent extends VisitEvent {
  const UpdateVisitEvent({required this.visit});

  final Visit visit;
}

class SyncVisitEvent extends VisitEvent {
  const SyncVisitEvent({required this.visit});

  final Visit visit;
}
