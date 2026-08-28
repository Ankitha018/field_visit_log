import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class LoadingView extends StatelessWidget {
  final double? size;
  final double strokeWidth;

  const LoadingView({super.key, this.size, this.strokeWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    final indicatorSize = size ?? AppDimensions.iconSize;

    return Center(
      child: SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
