/// States for Panel BLoC
/// These states represent all possible states of the left panel
/// (expanded, collapsed, animating).
library;

import 'package:equatable/equatable.dart';

/// Base class for all panel states
/// All panel states extend this class for type safety and equality comparison
abstract class PanelState extends Equatable {
  const PanelState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the panel
/// Used when the panel is first created and not yet initialized
class PanelInitial extends PanelState {
  const PanelInitial();

  @override
  String toString() => 'PanelInitial';
}

/// State when the panel is expanded
/// The left panel is visible and showing the guest list
class PanelExpanded extends PanelState {
  /// Width of the expanded panel in logical pixels
  final double panelWidth;

  /// Whether this state change should be animated
  final bool animate;

  /// Animation duration for this state change
  final Duration? animationDuration;

  const PanelExpanded({
    required this.panelWidth,
    this.animate = true,
    this.animationDuration,
  });

  @override
  List<Object?> get props => [panelWidth, animate, animationDuration];

  @override
  String toString() => 'PanelExpanded(width: $panelWidth, animate: $animate, duration: $animationDuration)';
}

/// State when the panel is collapsed
/// The left panel is hidden and only the right panel is visible
class PanelCollapsed extends PanelState {
  /// Whether this state change should be animated
  final bool animate;

  /// Animation duration for this state change
  final Duration? animationDuration;

  const PanelCollapsed({
    this.animate = true,
    this.animationDuration,
  });

  @override
  List<Object?> get props => [animate, animationDuration];

  @override
  String toString() => 'PanelCollapsed(animate: $animate, duration: $animationDuration)';
}

/// State when the panel is currently animating
/// Used to prevent multiple simultaneous animations
class PanelAnimating extends PanelState {
  /// Whether animating to expanded (true) or collapsed (false) state
  final bool toExpanded;

  /// Current animation progress (0.0 to 1.0)
  final double progress;

  /// Duration of the animation
  final Duration duration;

  const PanelAnimating({
    required this.toExpanded,
    required this.progress,
    required this.duration,
  });

  @override
  List<Object?> get props => [toExpanded, progress, duration];

  @override
  String toString() => 'PanelAnimating(toExpanded: $toExpanded, progress: $progress, duration: $duration)';
}

// ========== STATE EXTENSIONS ==========

/// Extension methods for panel state convenience
extension PanelStateExtensions on PanelState {
  /// Check if the panel is currently expanded
  bool get isExpanded => this is PanelExpanded;

  /// Check if the panel is currently collapsed
  bool get isCollapsed => this is PanelCollapsed;

  /// Check if the panel is currently animating
  bool get isAnimating => this is PanelAnimating;

  /// Check if the panel is in its initial state
  bool get isInitial => this is PanelInitial;

  /// Get the current panel width (0 if collapsed, full width if expanded)
  double getCurrentWidth(double expandedWidth) {
    final currentState = this;
    
    if (currentState is PanelExpanded) {
      return currentState.panelWidth;
    } else if (currentState is PanelAnimating) {
      if (currentState.toExpanded) {
        return expandedWidth * currentState.progress;
      } else {
        return expandedWidth * (1.0 - currentState.progress);
      }
    }
    return 0.0; // Collapsed or initial
  }

  /// Check if the state should trigger an animation
  bool get shouldAnimate {
    if (this is PanelExpanded) {
      return (this as PanelExpanded).animate;
    } else if (this is PanelCollapsed) {
      return (this as PanelCollapsed).animate;
    }
    return false;
  }

  /// Get the animation duration for this state
  Duration? get animationDuration {
    if (this is PanelExpanded) {
      return (this as PanelExpanded).animationDuration;
    } else if (this is PanelCollapsed) {
      return (this as PanelCollapsed).animationDuration;
    } else if (this is PanelAnimating) {
      return (this as PanelAnimating).duration;
    }
    return null;
  }
}
