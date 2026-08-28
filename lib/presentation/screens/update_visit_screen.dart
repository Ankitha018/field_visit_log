import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Update Visit')),
      body: BlocListener<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitUpdated) {
            Navigator.pop(context);
            return;
          }

          if (state is VisitError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: VisitForm(
            initialSiteName: visit.siteName,
            initialDate: visit.date,
            initialLocation: visit.location,
            initialNotes: visit.notes,
            buttonText: 'Update',
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
