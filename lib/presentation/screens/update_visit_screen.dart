import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/snackbar_helper.dart';
import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class UpdateVisitScreen extends StatelessWidget {
  const UpdateVisitScreen({super.key, required this.visit});
  final Visit visit;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: MaterialLocalizations.of(context).closeButtonLabel,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.updateVisit),
      ),
      body: BlocListener<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitUpdated) {
            Navigator.pop(context, state.visit);
            return;
          }
          if (state is VisitError) {
            SnackbarHelper.showError(context, state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: VisitForm(
            initialSiteName: visit.siteName,
            initialDate: visit.date,
            initialLocation: visit.location,
            initialNotes: visit.notes,
            buttonText: l10n.saveChanges,
            onSubmit:
                ({
                  required String siteName,
                  required DateTime date,
                  required String location,
                  required String notes,
                }) {
                  final updatedVisit = visit.copyWith(
                    siteName: siteName,
                    date: date,
                    location: location,
                    notes: notes,
                  );
                  context.read<VisitBloc>().add(
                    UpdateVisitEvent(visit: updatedVisit),
                  );
                },
          ),
        ),
      ),
    );
  }
}
