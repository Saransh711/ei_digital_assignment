/// Responsive design utility functions for layout calculations
/// These utilities provide consistent responsive behavior across the application
/// and handle complex responsive logic.
library;

import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../constants/responsive_constants.dart';

/// Utility class for responsive design calculations and helpers
class ResponsiveHelper {
  // Private constructor to prevent instantiation
  ResponsiveHelper._();

  /// Calculate responsive width percentage
  /// Returns a percentage of screen width based on the current screen size
  static double getWidthPercentage(BuildContext context, double percentage) {
    return context.screenWidth * (percentage / 100);
  }

  /// Calculate responsive height percentage
  /// Returns a percentage of screen height based on the current screen size
  static double getHeightPercentage(BuildContext context, double percentage) {
    return context.screenHeight * (percentage / 100);
  }

  /// Get optimal font size based on screen width
  /// Automatically adjusts font size to ensure readability across devices
  static double getOptimalFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = context.screenWidth;
    final scaleFactor = screenWidth / ResponsiveBreakpoints.mediumTablet;

    // Clamp scale factor to prevent text from becoming too small or large
    final clampedScale = scaleFactor.clamp(0.8, 1.5);

    return baseFontSize * clampedScale;
  }

  /// Calculate responsive spacing based on screen size
  /// Ensures consistent spacing proportions across different screen sizes
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    return context.responsiveValue(
      small: baseSpacing * 0.8,
      medium: baseSpacing,
      large: baseSpacing * 1.2,
      extraLarge: baseSpacing * 1.4,
    );
  }

  /// Get grid column count based on screen size
  /// Useful for responsive grid layouts
  static int getGridColumns(BuildContext context, {int maxColumns = 4}) {
    return context.responsiveValue(
      small: 2.clamp(1, maxColumns),
      medium: 3.clamp(1, maxColumns),
      large: 4.clamp(1, maxColumns),
      extraLarge: maxColumns,
    );
  }

  /// Calculate responsive card width for list items
  /// Ensures cards have appropriate width for different screen sizes
  static double getCardWidth(BuildContext context) {
    final screenWidth = context.screenWidth;

    if (context.isSmallTablet) {
      return screenWidth * 0.9; // 90% width on small tablets
    } else if (context.isMediumTablet) {
      return screenWidth * 0.7; // 70% width on medium tablets
    } else if (context.isLargeTablet) {
      return screenWidth * 0.5; // 50% width on large tablets
    } else {
      return screenWidth * 0.4; // 40% width on extra large tablets
    }
  }

  /// Get appropriate icon size for current screen
  static double getResponsiveIconSize(BuildContext context, double baseSize) {
    return context.responsiveValue(
      small: baseSize,
      medium: baseSize * 1.1,
      large: baseSize * 1.2,
      extraLarge: baseSize * 1.3,
    );
  }

  /// Calculate appropriate list item height
  static double getListItemHeight(BuildContext context) {
    return context.responsiveValue(
      small: 72.0,
      medium: 80.0,
      large: 88.0,
      extraLarge: 96.0,
    );
  }

  /// Get responsive button height
  static double getButtonHeight(BuildContext context) {
    return context.responsiveValue(
      small: 44.0,
      medium: 48.0,
      large: 52.0,
      extraLarge: 56.0,
    );
  }

  /// Calculate optimal number of columns for a responsive layout
  static int getOptimalColumns(
    BuildContext context, {
    required double itemWidth,
    double spacing = 16.0,
  }) {
    final screenWidth = context.screenWidth;
    final availableWidth =
        screenWidth - (spacing * 2); // Account for side margins

    int columns = (availableWidth / (itemWidth + spacing)).floor();
    return columns.clamp(1, 6); // Ensure at least 1, max 6 columns
  }

  /// Check if screen supports dual panel layout
  static bool supportsDualPanel(BuildContext context) {
    return context.screenWidth >= ResponsiveBreakpoints.smallTablet;
  }

  /// Check if panel should be collapsed by default
  static bool shouldCollapsePanel(BuildContext context) {
    // Only collapse on small tablets by default
    return context.isSmallTablet;
  }

  /// Get appropriate AppBar height for current screen
  static double getAppBarHeight(BuildContext context) {
    return context.responsiveValue(
      small: 56.0,
      medium: 60.0,
      large: 64.0,
      extraLarge: 68.0,
    );
  }

  /// Calculate responsive border radius
  static double getResponsiveBorderRadius(
    BuildContext context,
    double baseRadius,
  ) {
    return context.responsiveValue(
      small: baseRadius,
      medium: baseRadius * 1.1,
      large: baseRadius * 1.2,
      extraLarge: baseRadius * 1.3,
    );
  }

  /// Get responsive elevation for cards and surfaces
  static double getResponsiveElevation(
    BuildContext context,
    double baseElevation,
  ) {
    return context.responsiveValue(
      small: baseElevation,
      medium: baseElevation * 1.1,
      large: baseElevation * 1.2,
      extraLarge: baseElevation * 1.3,
    );
  }

  /// Calculate safe area padding adjustments
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EdgeInsets.only(
      top: mediaQuery.padding.top,
      bottom: mediaQuery.padding.bottom,
      left: mediaQuery.padding.left,
      right: mediaQuery.padding.right,
    );
  }

  /// Get responsive content padding for main areas
  static EdgeInsets getContentPadding(BuildContext context) {
    return EdgeInsets.all(
      context.responsiveValue(
        small: 16.0,
        medium: 20.0,
        large: 24.0,
        extraLarge: 28.0,
      ),
    );
  }

  /// Calculate responsive margin for cards and containers
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    return EdgeInsets.all(
      context.responsiveValue(
        small: 8.0,
        medium: 12.0,
        large: 16.0,
        extraLarge: 20.0,
      ),
    );
  }
}
