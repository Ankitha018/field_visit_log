import 'package:flutter/material.dart';

import '../../core/components/cards/app_card.dart';
import '../../core/components/chips/status_chip.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/visit.dart';
import '../../domain/enums/visit_status.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({super.key, required this.visit, this.onTap});

  final Visit visit;
  final VoidCallback? onTap;

  StatusChipType _getStatusChipType(VisitStatus status) {
    switch (status) {
      case VisitStatus.draft:
        return StatusChipType.warning;
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
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(visit.siteName, style: AppTextStyles.title),
                SizedBox(height: AppSpacing.paddingXs),
                Text(visit.location, style: AppTextStyles.bodySecondary),
                SizedBox(height: AppSpacing.paddingXs),
                Text(
                  visit.notes,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.paddingSm),
          StatusChip(
            type: _getStatusChipType(visit.status),
            label: _getStatusLabel(visit.status),
          ),
        ],
      ),
    );
  }
}
