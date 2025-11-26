/// UI spacing, sizing, and layout constants extracted from design screenshots
/// These values ensure consistent spacing and sizing throughout the application
/// and maintain visual hierarchy as seen in the guest book interface.
library;

/// Spacing scale based on 4dp grid system from Material Design
/// All spacing values extracted by analyzing screenshot measurements
class UIConstants {
  // Private constructor to prevent instantiation
  UIConstants._();

  // ========== SPACING CONSTANTS ==========

  /// Extra small spacing: 4dp
  /// Used for: Tight spacing between related elements
  static const double spacingXS = 4.0;

  /// Small spacing: 8dp
  /// Used for: Close related content, inner padding
  static const double spacingS = 8.0;

  /// Medium spacing: 16dp
  /// Used for: Standard content spacing, card padding
  static const double spacingM = 16.0;

  /// Large spacing: 24dp
  /// Used for: Section spacing, major content gaps
  static const double spacingL = 24.0;

  /// Extra large spacing: 32dp
  /// Used for: Major layout separation, screen margins
  static const double spacingXL = 32.0;

  /// Extra extra large spacing: 48dp
  /// Used for: Major section separation
  static const double spacingXXL = 48.0;

  // ========== BORDER RADIUS CONSTANTS ==========

  /// Small border radius: 4dp
  /// Used for: Small UI elements, buttons
  static const double radiusS = 4.0;

  /// Medium border radius: 8dp
  /// Used for: Standard buttons, inputs
  static const double radiusM = 8.0;

  /// Large border radius: 12dp
  /// Used for: Cards, major containers (extracted from screenshot cards)
  static const double radiusL = 12.0;

  /// Extra large border radius: 16dp
  /// Used for: Prominent containers
  static const double radiusXL = 16.0;

  /// Circular radius: 50% (for circular elements)
  static const double radiusCircular = 100.0;

  // ========== ELEVATION CONSTANTS ==========

  /// No elevation
  static const double elevationNone = 0.0;

  /// Low elevation: 2dp
  /// Used for: Subtle card separation
  static const double elevationLow = 2.0;

  /// Medium elevation: 4dp
  /// Used for: Standard cards, floating elements
  static const double elevationMedium = 4.0;

  /// High elevation: 8dp
  /// Used for: Modal dialogs, prominent elements
  static const double elevationHigh = 8.0;

  /// Very high elevation: 16dp
  /// Used for: Navigation drawers, overlays
  static const double elevationVeryHigh = 16.0;

  // ========== AVATAR CONSTANTS ==========

  /// Small avatar size: 32dp
  static const double avatarSmall = 32.0;

  /// Medium avatar size: 48dp (standard size from screenshots)
  static const double avatarMedium = 48.0;

  /// Large avatar size: 64dp
  static const double avatarLarge = 64.0;

  /// Extra large avatar size: 96dp
  static const double avatarXLarge = 96.0;

  // ========== ICON CONSTANTS ==========

  /// Small icon size: 16dp
  static const double iconSmall = 16.0;

  /// Medium icon size: 24dp (standard Material icon size)
  static const double iconMedium = 24.0;

  /// Large icon size: 32dp
  static const double iconLarge = 32.0;

  // ========== BUTTON CONSTANTS ==========

  /// Standard button height: 48dp
  static const double buttonHeight = 48.0;

  /// Compact button height: 36dp
  static const double buttonHeightCompact = 36.0;

  /// Small button height: 28dp
  static const double buttonHeightSmall = 28.0;

  /// Button minimum width: 64dp
  static const double buttonMinWidth = 64.0;

  // ========== APPBAR CONSTANTS ==========

  /// AppBar height: 56dp (Material Design standard)
  static const double appBarHeight = 56.0;

  /// AppBar elevation
  static const double appBarElevation = 4.0;

  // ========== CARD CONSTANTS ==========

  /// Standard card margin
  static const double cardMargin = spacingM;

  /// Standard card padding
  static const double cardPadding = spacingM;

  /// Card elevation (extracted from screenshot analysis)
  static const double cardElevation = elevationMedium;
}
