import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_spacing.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});
  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  static const int _skeletonCount = 4;
  static const Duration _shimmerDuration = Duration(milliseconds: 1200);
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shimmerDuration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shimmerPosition = (_controller.value * 2) - 1;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(shimmerPosition - 1, 0),
              end: Alignment(shimmerPosition + 1, 0),
              colors: const [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: _skeletonCount,
        separatorBuilder: (_, _) {
          return const SizedBox(height: AppSpacing.gapMd);
        },
        itemBuilder: (context, index) {
          return const _VisitCardSkeleton();
        },
      ),
    );
  }
}

class _VisitCardSkeleton extends StatelessWidget {
  const _VisitCardSkeleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: AppDimensions.cardMinHeight),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonLine(height: AppSpacing.lg),
                SizedBox(height: AppSpacing.gapSm),
                FractionallySizedBox(
                  widthFactor: 0.55,
                  child: _SkeletonLine(height: AppSpacing.md),
                ),
                SizedBox(height: AppSpacing.gapSm),
                FractionallySizedBox(
                  widthFactor: 0.75,
                  child: _SkeletonLine(height: AppSpacing.md),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.gapMd),
          _SkeletonLine(
            width: AppDimensions.iconLarge + AppSpacing.sm,
            height: AppSpacing.xl,
            radius: AppSpacing.xl,
          ),
        ],
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({
    this.width,
    required this.height,
    this.radius = AppSpacing.xs,
  });
  final double? width;
  final double height;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
