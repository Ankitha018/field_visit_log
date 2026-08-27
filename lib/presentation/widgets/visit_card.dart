import 'package:flutter/material.dart';

import '../../core/components/chips/status_chip.dart';
import '../../core/extensions/date_extensions.dart';
import '../../domain/entities/visit.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({
    super.key,
    required this.visit,
    this.onTap,
  });

  final Visit visit;
  final VoidCallback? onTap;

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
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    visit.location,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  StatusChip(
                    label: _getStatusLabel(visit.status),
                    type: _getStatusType(visit.status),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                visit.date.displayDate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                visit.note,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}