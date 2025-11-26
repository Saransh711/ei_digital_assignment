/// Widget extensions for common operations and responsive behavior
/// These extensions provide convenient methods for widget composition
/// and responsive design patterns.
library;

import 'package:flutter/material.dart';
import '../constants/ui_constants.dart';

/// Extension methods on Widget for common operations
extension WidgetExtensions on Widget {
  // ========== PADDING EXTENSIONS ==========

  /// Add symmetric padding
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Add all-sides padding
  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// Add custom padding with EdgeInsets
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Add standard UI spacing padding
  Widget paddingStandard() => paddingAll(UIConstants.spacingM);

  /// Add small padding
  Widget paddingSmall() => paddingAll(UIConstants.spacingS);

  /// Add large padding
  Widget paddingLarge() => paddingAll(UIConstants.spacingL);

  // ========== MARGIN EXTENSIONS ==========

  /// Add symmetric margin using Container
  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Add all-sides margin
  Widget marginAll(double margin) {
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  /// Add custom margin
  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  // ========== ALIGNMENT EXTENSIONS ==========

  /// Center the widget
  Widget centered() => Center(child: this);

  /// Align the widget
  Widget aligned(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }

  /// Align to center left
  Widget alignedCenterLeft() => aligned(Alignment.centerLeft);

  /// Align to center right
  Widget alignedCenterRight() => aligned(Alignment.centerRight);

  /// Align to top left
  Widget alignedTopLeft() => aligned(Alignment.topLeft);

  /// Align to top right
  Widget alignedTopRight() => aligned(Alignment.topRight);

  // ========== FLEX EXTENSIONS ==========

  /// Wrap in Expanded widget
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);

  /// Wrap in Flexible widget
  Widget flexible([int flex = 1]) => Flexible(flex: flex, child: this);

  // ========== GESTURE EXTENSIONS ==========

  /// Add tap gesture
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Add long press gesture
  Widget onLongPress(VoidCallback onLongPress) {
    return GestureDetector(onLongPress: onLongPress, child: this);
  }

  /// Add double tap gesture
  Widget onDoubleTap(VoidCallback onDoubleTap) {
    return GestureDetector(onDoubleTap: onDoubleTap, child: this);
  }

  // ========== CONTAINER EXTENSIONS ==========

  /// Wrap in container with background color
  Widget withBackground(Color color) {
    return Container(color: color, child: this);
  }

  /// Wrap in container with border radius
  Widget withBorderRadius(double radius) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: this,
    );
  }

  /// Wrap in card with standard styling
  Widget asCard({
    double? elevation,
    double? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Card(
      elevation: elevation ?? UIConstants.cardElevation,
      margin: margin ?? EdgeInsets.all(UIConstants.cardMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? UIConstants.radiusL,
        ),
      ),
      child: padding != null ? Padding(padding: padding, child: this) : this,
    );
  }

  // ========== ANIMATION EXTENSIONS ==========

  /// Add fade transition
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      curve: curve,
      child: this,
    );
  }

  /// Add scale transition
  Widget scaleIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return AnimatedScale(
      scale: 1.0,
      duration: duration,
      curve: curve,
      child: this,
    );
  }

  // ========== CONDITIONAL EXTENSIONS ==========

  /// Show widget conditionally
  Widget showIf(bool condition) {
    return condition ? this : const SizedBox.shrink();
  }

  /// Show widget with alternative
  Widget showIfElse(bool condition, Widget alternative) {
    return condition ? this : alternative;
  }

  // ========== SLIVER EXTENSIONS ==========

  /// Convert to sliver
  Widget toSliver() => SliverToBoxAdapter(child: this);

  // ========== HERO EXTENSIONS ==========

  /// Wrap in Hero widget
  Widget hero(String tag) => Hero(tag: tag, child: this);

  // ========== SEMANTIC EXTENSIONS ==========

  /// Add semantic label
  Widget semantic(String label) {
    return Semantics(label: label, child: this);
  }

  /// Add semantic button
  Widget semanticButton(String label) {
    return Semantics(label: label, button: true, child: this);
  }
}
