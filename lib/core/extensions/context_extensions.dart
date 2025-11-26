/// Context extensions for responsive design and common operations
/// These extensions provide easy access to responsive sizing, theme data,
/// and screen information throughout the application.
library;

import 'package:flutter/material.dart';
import '../constants/responsive_constants.dart';

/// Screen size categories for responsive design
enum ScreenType {
  small,    // 600dp - 800dp
  medium,   // 800dp - 1024dp  
  large,    // 1024dp - 1366dp
  extraLarge, // 1366dp+
}

/// Extension methods on BuildContext for responsive design and utilities
extension ContextExtensions on BuildContext {
  
  // ========== SCREEN SIZE UTILITIES ==========

  /// Get the current screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the current screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get screen size information
  Size get screenSize => MediaQuery.of(this).size;

  /// Get device pixel ratio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Check if device is in landscape orientation
  bool get isLandscape => 
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if device is in portrait orientation
  bool get isPortrait => 
      MediaQuery.of(this).orientation == Orientation.portrait;

  // ========== RESPONSIVE BREAKPOINTS ==========

  /// Determine the current screen type based on width
  ScreenType get screenType {
    final width = screenWidth;
    
    if (width >= ResponsiveBreakpoints.extraLargeTablet) {
      return ScreenType.extraLarge;
    } else if (width >= ResponsiveBreakpoints.largeTablet) {
      return ScreenType.large;
    } else if (width >= ResponsiveBreakpoints.mediumTablet) {
      return ScreenType.medium;
    } else {
      return ScreenType.small;
    }
  }

  /// Check if screen is small tablet size
  bool get isSmallTablet => screenType == ScreenType.small;

  /// Check if screen is medium tablet size
  bool get isMediumTablet => screenType == ScreenType.medium;

  /// Check if screen is large tablet size
  bool get isLargeTablet => screenType == ScreenType.large;

  /// Check if screen is extra large tablet size
  bool get isExtraLargeTablet => screenType == ScreenType.extraLarge;

  // ========== RESPONSIVE SIZING ==========

  /// Get responsive value based on screen type
  T responsiveValue<T>({
    required T small,
    required T medium,
    required T large,
    required T extraLarge,
  }) {
    switch (screenType) {
      case ScreenType.small:
        return small;
      case ScreenType.medium:
        return medium;
      case ScreenType.large:
        return large;
      case ScreenType.extraLarge:
        return extraLarge;
    }
  }

  /// Get responsive font size with automatic scaling
  /// Base size is for small screens, scales up for larger screens
  double responsiveFontSize(double baseSize) {
    return responsiveValue(
      small: baseSize,
      medium: baseSize * 1.1,
      large: baseSize * 1.2,
      extraLarge: baseSize * 1.3,
    );
  }

  /// Get responsive padding value
  double responsivePadding(double basePadding) {
    return responsiveValue(
      small: basePadding,
      medium: basePadding * 1.2,
      large: basePadding * 1.4,
      extraLarge: basePadding * 1.6,
    );
  }

  /// Get responsive margin value
  double responsiveMargin(double baseMargin) {
    return responsiveValue(
      small: baseMargin,
      medium: baseMargin * 1.2,
      large: baseMargin * 1.4,
      extraLarge: baseMargin * 1.6,
    );
  }

  /// Get left panel width based on screen size
  double get leftPanelWidth {
    return responsiveValue(
      small: PanelConstants.leftPanelSmall,
      medium: PanelConstants.leftPanelMedium,
      large: PanelConstants.leftPanelLarge,
      extraLarge: PanelConstants.leftPanelExtraLarge,
    );
  }

  // ========== THEME ACCESS ==========

  /// Get current theme data
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  // ========== NAVIGATION UTILITIES ==========

  /// Push a new route
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop current route
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  // ========== FOCUS UTILITIES ==========

  /// Unfocus current focus node (hide keyboard)
  void unfocus() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  // ========== SNACKBAR UTILITIES ==========

  /// Show success snackbar
  void showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show info snackbar
  void showInfoSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
