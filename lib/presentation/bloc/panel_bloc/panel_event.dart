/// Events for Panel BLoC
/// These events represent all possible user actions that can affect
/// the left panel state (expand, collapse, toggle).
library;

import 'package:equatable/equatable.dart';

/// Base class for all panel events
/// All panel events extend this class for type safety and equality comparison
abstract class PanelEvent extends Equatable {
  const PanelEvent();

  @override
  List<Object?> get props => [];
}

/// Event to expand the left panel
/// Triggered when user clicks the back button in the app bar
/// or when the panel should be shown
class ExpandPanelEvent extends PanelEvent {
  const ExpandPanelEvent();

  @override
  String toString() => 'ExpandPanelEvent';
}

/// Event to collapse the left panel
/// Triggered when user taps anywhere on the right panel
/// or when the panel should be hidden
class CollapsePanelEvent extends PanelEvent {
  const CollapsePanelEvent();

  @override
  String toString() => 'CollapsePanelEvent';
}

/// Event to toggle the panel state
/// Switches between expanded and collapsed states
/// Useful for cases where the current state is unknown
class TogglePanelEvent extends PanelEvent {
  const TogglePanelEvent();

  @override
  String toString() => 'TogglePanelEvent';
}

/// Event to initialize the panel state
/// Sets the initial state based on screen size and user preferences
class InitializePanelEvent extends PanelEvent {
  /// Whether the panel should be expanded by default
  final bool shouldExpand;

  const InitializePanelEvent({
    required this.shouldExpand,
  });

  @override
  List<Object?> get props => [shouldExpand];

  @override
  String toString() => 'InitializePanelEvent(shouldExpand: $shouldExpand)';
}

/// Event to set panel state explicitly
/// Used when you need to set a specific state regardless of current state
class SetPanelStateEvent extends PanelEvent {
  /// Whether the panel should be expanded
  final bool isExpanded;

  /// Optional animation duration override
  final Duration? animationDuration;

  const SetPanelStateEvent({
    required this.isExpanded,
    this.animationDuration,
  });

  @override
  List<Object?> get props => [isExpanded, animationDuration];

  @override
  String toString() => 'SetPanelStateEvent(isExpanded: $isExpanded, duration: $animationDuration)';
}
