import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class CreateVisitScreen extends StatelessWidget {
  const CreateVisitScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Visit'),
      ),
      body: BlocListener<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitLoaded) {
            Navigator.pop(context);
          }

          if (state is VisitError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: VisitForm(
            onSubmit: () {
              final visit = Visit(
                id: DateTime.now()
                    .microsecondsSinceEpoch
                    .toString(),
                date: DateTime.now(),
                location: 'New Location',
                note: 'New Visit',
                status: VisitStatus.draft,
                createdAt: DateTime.now(),
              );

              context.read<VisitBloc>().add(
                CreateVisitEvent(
                  visit: visit,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}