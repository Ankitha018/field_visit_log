import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

enum StatusChipType { neutral, success, warning, error, primary }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusChipType type;

  const StatusChip({super.key, required this.label, required this.type});

  Color get _backgroundColor {
    switch (type) {
      case StatusChipType.neutral:
        return const Color(0xFFF0EDE7);

      case StatusChipType.success:
        return const Color(0xFFE4F4EA);

      case StatusChipType.warning:
        return const Color(0xFFFFF2D8);

      case StatusChipType.error:
        return const Color(0xFFFCE5E5);

      case StatusChipType.primary:
        return const Color(0xFFFFE9DD);
    }
  }

  Color get _foregroundColor {
    switch (type) {
      case StatusChipType.neutral:
        return const Color(0xFF6F6A62);
      case StatusChipType.success:
        return const Color(0xFF27834B);
      case StatusChipType.warning:
        return const Color(0xFF9A6810);
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
        horizontal: AppSpacing.paddingSm,
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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
