import 'package:flutter/material.dart';

/// Application color constants extracted from the guest book screenshots
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  /// Primary brand color - used for active states and highlights
  /// Extracted from screenshot: tab highlights and accent elements
  static const Color primary = Color(0xFF2196F3);

  /// Secondary accent color for subtle highlights
  static const Color accent = Color(0xFF1976D2);

  /// Dark sidebar background - extracted from left panel in screenshots
  static const Color darkSidebar = Color(0xFF2D2D30);

  /// Light panel background - extracted from right panel content area
  static const Color lightPanel = Color(0xFFFFFFFF);

  /// Main background color for the application
  static const Color background = Color(0xFFF5F5F5);

  /// Surface color for cards and elevated components
  static const Color surface = Color(0xFFFFFFFF);

  static const Color grey = Color(0xFFf8f8f8);

  /// Primary text color for headings and important content
  static const Color textPrimary = Color(0xFF212121);

  static const Color detailPanelColor = Color(0xFF666666);

  static const Color detailPanelTextColor = Color(0xFF000000);

  /// Secondary text color for supporting information
  static const Color textSecondary = Color(0xFF44474E);

  /// Tertiary text color for hints and subtle information
  static const Color textTertiary = Color(0xFF9E9E9E);

  /// Text color for content on dark backgrounds
  static const Color textOnDark = Color(0xFFFFFFFF);

  /// Divider color for separating content sections
  static const Color divider = Color(0xFFE0E0E0);

  /// Border color for input fields and containers
  static const Color border = Color(0xFFCCCCCC);

  /// Success color for positive states and confirmations
  static const Color success = Color(0xFF4CAF50);

  /// Warning color for attention-requiring states
  static const Color warning = Color(0xFFFF9800);

  /// Error color for negative states and validation messages
  static const Color error = Color(0xFFF44336);

  /// Shadow color for elevation effects
  static const Color shadow = Color(0x1F000000);
}
