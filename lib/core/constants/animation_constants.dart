import 'package:flutter/material.dart';

class AnimationConstants {
  // Private constructor to prevent instantiation
  AnimationConstants._();

  // ========== DURATION CONSTANTS ==========

  /// Panel collapse/expand animation duration
  /// Used for: Left panel show/hide transitions
  static const Duration panelAnimation = Duration(milliseconds: 300);

  /// Fast animation duration for quick UI feedback
  /// Used for: Button presses, selection states
  static const Duration fast = Duration(milliseconds: 150);

  /// Medium animation duration for standard transitions
  /// Used for: Page transitions, modal appearances
  static const Duration medium = Duration(milliseconds: 250);

  /// Slow animation duration for complex transitions
  /// Used for: Complex layout changes, data loading states
  static const Duration slow = Duration(milliseconds: 400);

  /// Extra slow animation duration for emphasis
  /// Used for: Important state changes, error states
  static const Duration extraSlow = Duration(milliseconds: 600);

  // ========== CURVE CONSTANTS ==========

  /// Smooth ease-in-out curve for panel animations
  /// Creates natural feeling expand/collapse motion
  static const Curve panelCurve = Curves.easeInOut;

  /// Fast out slow in curve for responsive interactions
  /// Used for: Button presses, immediate feedback
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  /// Ease in curve for elements appearing
  /// Used for: Modal dialogs, overlay appearances
  static const Curve easeIn = Curves.easeIn;

  /// Ease out curve for elements disappearing
  /// Used for: Modal dismissals, element removals
  static const Curve easeOut = Curves.easeOut;

  /// Linear curve for consistent motion
  /// Used for: Loading animations, progress indicators
  static const Curve linear = Curves.linear;

  /// Bounce curve for playful interactions
  /// Used sparingly for special interactions
  static const Curve bounce = Curves.bounceOut;

  // ========== ANIMATION VALUES ==========

  /// Opacity values for fade animations
  static const double opacityVisible = 1.0;
  static const double opacityHidden = 0.0;
  static const double opacityDimmed = 0.6;

  /// Scale values for scaling animations
  static const double scaleNormal = 1.0;
  static const double scalePressed = 0.95;
  static const double scaleExpanded = 1.05;
  static const double scaleHidden = 0.0;

  /// Offset values for slide animations
  static const Offset slideLeft = Offset(-1.0, 0.0);
  static const Offset slideRight = Offset(1.0, 0.0);
  static const Offset slideUp = Offset(0.0, -1.0);
  static const Offset slideDown = Offset(0.0, 1.0);
  static const Offset slideCenter = Offset.zero;
}
