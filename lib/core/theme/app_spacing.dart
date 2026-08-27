import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Base spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  // Common gaps
  static const double gapXs = xs;
  static const double gapSm = sm;
  static const double gapMd = md;
  static const double gapLg = lg;
  static const double gapXl = xl;
  static const double gapXxl = xxl;

  // Common padding
  static const double paddingXs = xs;
  static const double paddingSm = sm;
  static const double paddingMd = md;
  static const double paddingLg = lg;
  static const double paddingXl = xl;
  static const double paddingXxl = xxl;

  // EdgeInsets
  static const EdgeInsets screenPadding = EdgeInsets.all(lg);

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);

  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    vertical: xl,
  );
}