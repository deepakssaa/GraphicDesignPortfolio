import 'package:flutter/material.dart';

/// Responsive breakpoint helper for consistent layout decisions.
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  /// Returns one of three values depending on screen width.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }

  /// Grid cross-axis count based on screen width.
  static int gridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1400) return 4;
    if (width >= 1100) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  /// Content max width for centered layouts.
  static double contentMaxWidth(BuildContext context) {
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 800;
    return double.infinity;
  }
}
