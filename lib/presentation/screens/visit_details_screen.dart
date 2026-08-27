import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/buttons/primary_button.dart';
import '../../core/components/chips/status_chip.dart';
import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';

class VisitDetailsScreen extends StatelessWidget {
  const VisitDetailsScreen({
    super.key,
    required this.visit,
  });

  final Visit visit;

  StatusChipType _getStatusType(VisitStatus status) {
    switch (status) {
      case VisitStatus.draft:
        return StatusChipType.neutral;

      case VisitStatus.synced:
        return StatusChipType.success;

      case VisitStatus.failed:
        return StatusChipType.error;
    }
  }

  String _getStatusLabel(VisitStatus status) {
    switch (status) {
      case VisitStatus.draft:
        return 'Draft';

      case VisitStatus.synced:
        return 'Synced';

      case VisitStatus.failed:
        return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Details'),
      ),
      body: BlocConsumer<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitSynced) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Visit synced successfully.',
                ),
              ),
            );
          }

          if (state is VisitDraft) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Visit saved as draft.',
                ),
              ),
            );
          }

          if (state is VisitFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final saving = state is VisitSaving;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visit.location,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 16),

                Text(visit.note),

                const SizedBox(height: 16),

                StatusChip(
                  label: _getStatusLabel(visit.status),
                  type: _getStatusType(visit.status),
                ),

                const Spacer(),

                PrimaryButton(
                  label: saving ? 'Saving...' : 'Save',
                  onPressed: saving
                      ? null
                      : () {
                    context.read<VisitBloc>().add(
                      SyncVisitEvent(
                        visit: visit,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}