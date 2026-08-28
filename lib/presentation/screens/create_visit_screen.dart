import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/utils/snackbar_helper.dart';
import '../../domain/entities/visit.dart';
import '../../domain/enums/visit_status.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class CreateVisitScreen extends StatelessWidget {
  const CreateVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Visit')),
      body: BlocListener<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitCreated) {
            Navigator.pop(context);
            return;
          }

          if (state is VisitError) {
            SnackbarHelper.showError(context, state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.paddingMd),
          child: VisitForm(
            onSubmit:
                ({
                  required String siteName,
                  required DateTime date,
                  required String location,
                  required String notes,
                }) {
                  final now = DateTime.now();

                  final visit = Visit(
                    id: now.microsecondsSinceEpoch.toString(),
                    siteName: siteName,
                    date: date,
                    location: location,
                    notes: notes,
                    status: VisitStatus.draft,
                    createdAt: now,
                  );

                  context.read<VisitBloc>().add(CreateVisitEvent(visit: visit));
                },
          ),
        ),
      ),
    );
  }
}
