import '../../../domain/entities/visit.dart';

abstract class VisitState {
  const VisitState();
}

class VisitInitial extends VisitState {
  const VisitInitial();
}

class VisitLoading extends VisitState {
  const VisitLoading();
}

class VisitLoaded extends VisitState {
  const VisitLoaded({required this.visits});

  final List<Visit> visits;
}

class VisitEmpty extends VisitState {
  const VisitEmpty();
}

class VisitError extends VisitState {
  const VisitError({required this.message});

  final String message;
}

class VisitSaving extends VisitState {
  const VisitSaving();
}

class VisitCreated extends VisitState {
  const VisitCreated({required this.visit});

  final Visit visit;
}

// ADD IT HERE
class VisitUpdated extends VisitState {
  const VisitUpdated({required this.visit});

  final Visit visit;
}

class VisitSynced extends VisitState {
  const VisitSynced({required this.visit});

  final Visit visit;
}

class VisitDraft extends VisitState {
  const VisitDraft({required this.visit});

  final Visit visit;
}

class VisitFailed extends VisitState {
  const VisitFailed({required this.visit, required this.message});

  final Visit visit;
  final String message;
}
