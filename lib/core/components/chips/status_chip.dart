import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

enum StatusChipType {
  neutral,
  success,
  warning,
  error,
  primary,
}

class StatusChip extends StatelessWidget {
  final String label;
  final StatusChipType type;

  const StatusChip({
    super.key,
    required this.label,
    required this.type,
  });

  Color get _backgroundColor {
    switch (type) {
      case StatusChipType.neutral:
        return AppColors.hover;

      case StatusChipType.success:
        return AppColors.success.withValues(
          alpha: 0.12,
        );

      case StatusChipType.warning:
        return AppColors.warning.withValues(
          alpha: 0.12,
        );

      case StatusChipType.error:
        return AppColors.error.withValues(
          alpha: 0.12,
        );

      case StatusChipType.primary:
        return AppColors.primary.withValues(
          alpha: 0.08,
        );
    }
  }

  Color get _foregroundColor {
    switch (type) {
      case StatusChipType.neutral:
        return AppColors.muted;

      case StatusChipType.success:
        return AppColors.success;

      case StatusChipType.warning:
        return AppColors.warning;

      case StatusChipType.error:
        return AppColors.error;

      case StatusChipType.primary:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingXs,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: _foregroundColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}