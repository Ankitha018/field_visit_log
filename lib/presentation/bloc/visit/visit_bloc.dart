import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/visit.dart';
import '../../../domain/usecases/create_visit.dart';
import 'package:field_visit_log/domain/usecases/get_visits.dart';
import '../../../domain/usecases/sync_visits.dart';
import '../../../domain/usecases/update_visit.dart';
import 'visit_event.dart';
import 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  VisitBloc({
    required GetVisits getVisits,
    required CreateVisit createVisit,
    required UpdateVisit updateVisit,
    required SyncVisits syncVisits,
  })  : _getVisits = getVisits,
        _createVisit = createVisit,
        _updateVisit = updateVisit,
        _syncVisits = syncVisits,
        super(const VisitInitial()) {
    on<LoadVisits>(_onLoadVisits);
    on<CreateVisitEvent>(_onCreateVisit);
    on<UpdateVisitEvent>(_onUpdateVisit);
    on<SyncVisitEvent>(_onSyncVisit);
  }

  final GetVisits _getVisits;
  final CreateVisit _createVisit;
  final UpdateVisit _updateVisit;
  final SyncVisits _syncVisits;

  Future<void> _onLoadVisits(
      LoadVisits event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      final visits = await _getVisits();

      if (visits.isEmpty) {
        emit(const VisitEmpty());
      } else {
        emit(
          VisitLoaded(
            visits: visits,
          ),
        );
      }
    } catch (error) {
      emit(
        VisitError(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onCreateVisit(
      CreateVisitEvent event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitSaving());

    try {
      await _createVisit(event.visit);
      final visits = await _getVisits();

      emit(
        VisitLoaded(
          visits: visits,
        ),
      );
    } catch (error) {
      emit(
        VisitError(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateVisit(
      UpdateVisitEvent event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitSaving());

    try {
      await _updateVisit(event.visit);
      final visits = await _getVisits();

      emit(
        VisitLoaded(
          visits: visits,
        ),
      );
    } catch (error) {
      emit(
        VisitError(
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onSyncVisit(
      SyncVisitEvent event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitSaving());

    try {
      final status =
      await _syncVisits(event.visit);

      final updated =
      event.visit.copyWith(
        status: status,
      );

      switch (status.value) {
        case 'synced':
          emit(
            VisitSynced(
              visit: updated,
            ),
          );
          break;

        case 'draft':
          emit(
            VisitDraft(
              visit: updated,
            ),
          );
          break;

        case 'failed':
          emit(
            VisitFailed(
              visit: updated,
              message:
              'Visit sync failed.',
            ),
          );
          break;
      }
    } catch (error) {
      emit(
        VisitFailed(
          visit: event.visit,
          message: error.toString(),
        ),
      );
    }
  }
}