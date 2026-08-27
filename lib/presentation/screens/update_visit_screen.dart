import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class UpdateVisitScreen extends StatelessWidget {
  const UpdateVisitScreen({
    super.key,
    required this.visit,
  });

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Visit'),
      ),
      body: BlocListener<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitLoaded) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: VisitForm(
            initialDate: visit.date,
            initialLocation: visit.location,
            initialNote: visit.note,
            buttonText: 'Update',
            onSubmit: () {
              context.read<VisitBloc>().add(
                UpdateVisitEvent(
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