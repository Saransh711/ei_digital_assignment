/// Panel BLoC for managing left panel expand/collapse state
/// This BLoC handles the UI state of the left panel according to user interactions
/// and responsive design requirements.
library;

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'panel_event.dart';
import 'panel_state.dart';
import '../../../core/constants/animation_constants.dart';
import '../../../core/constants/responsive_constants.dart';

/// BLoC for managing panel expand/collapse state
/// Handles user interactions to show/hide the left guest list panel
/// with smooth animations and responsive behavior
class PanelBloc extends Bloc<PanelEvent, PanelState> {
  /// Timer for animation state management
  Timer? _animationTimer;

  /// Current panel width based on screen size
  double _panelWidth = PanelConstants.leftPanelMedium;

  /// Creates a new PanelBloc instance
  /// Initializes with collapsed state by default
  PanelBloc() : super(const PanelInitial()) {
    // Register event handlers
    on<InitializePanelEvent>(_onInitializePanel);
    on<ExpandPanelEvent>(_onExpandPanel);
    on<CollapsePanelEvent>(_onCollapsePanel);
    on<TogglePanelEvent>(_onTogglePanel);
    on<SetPanelStateEvent>(_onSetPanelState);
  }

  // ========== PUBLIC GETTERS ==========

  /// Get the current panel width
  double get panelWidth => _panelWidth;

  /// Check if panel is currently expanded
  bool get isExpanded => state.isExpanded;

  /// Check if panel is currently collapsed
  bool get isCollapsed => state.isCollapsed;

  /// Check if panel is currently animating
  bool get isAnimating => state.isAnimating;

  // ========== PUBLIC METHODS ==========

  /// Update panel width based on screen size
  /// Should be called when screen size changes
  void updatePanelWidth(double newWidth) {
    _panelWidth = newWidth;
  }

  /// Dispose resources when BLoC is closed
  @override
  Future<void> close() {
    _animationTimer?.cancel();
    return super.close();
  }

  // ========== EVENT HANDLERS ==========

  /// Handle panel initialization
  /// Sets the initial state based on screen size and preferences
  Future<void> _onInitializePanel(
    InitializePanelEvent event,
    Emitter<PanelState> emit,
  ) async {
    if (event.shouldExpand) {
      add(const ExpandPanelEvent());
    } else {
      add(const CollapsePanelEvent());
    }
  }

  /// Handle panel expansion
  /// Expands the panel with smooth animation
  Future<void> _onExpandPanel(
    ExpandPanelEvent event,
    Emitter<PanelState> emit,
  ) async {
    // Prevent multiple animations
    if (state.isAnimating) return;

    // Already expanded
    if (state.isExpanded) return;

    // Start animation if not already expanded
    await _animateToState(
      emit,
      true,
      duration: AnimationConstants.panelAnimation,
    );
  }

  /// Handle panel collapse
  /// Collapses the panel with smooth animation
  Future<void> _onCollapsePanel(
    CollapsePanelEvent event,
    Emitter<PanelState> emit,
  ) async {
    // Prevent multiple animations
    if (state.isAnimating) return;

    // Already collapsed
    if (state.isCollapsed) return;

    // Start animation if not already collapsed
    await _animateToState(
      emit,
      false,
      duration: AnimationConstants.panelAnimation,
    );
  }

  /// Handle panel toggle
  /// Switches between expanded and collapsed states
  Future<void> _onTogglePanel(
    TogglePanelEvent event,
    Emitter<PanelState> emit,
  ) async {
    // Prevent multiple animations
    if (state.isAnimating) return;

    if (state.isExpanded) {
      // Currently expanded, collapse it
      add(const CollapsePanelEvent());
    } else {
      // Currently collapsed or initial, expand it
      add(const ExpandPanelEvent());
    }
  }

  /// Handle explicit state setting
  /// Sets panel to specific state with optional animation
  Future<void> _onSetPanelState(
    SetPanelStateEvent event,
    Emitter<PanelState> emit,
  ) async {
    // Prevent multiple animations
    if (state.isAnimating) return;

    final targetExpanded = event.isExpanded;
    final currentExpanded = state.isExpanded;

    // No change needed
    if (targetExpanded == currentExpanded) return;

    final duration =
        event.animationDuration ?? AnimationConstants.panelAnimation;

    // Animate to target state
    await _animateToState(emit, targetExpanded, duration: duration);
  }

  // ========== PRIVATE HELPER METHODS ==========

  /// Animate panel to target state with progress updates
  Future<void> _animateToState(
    Emitter<PanelState> emit,
    bool toExpanded, {
    required Duration duration,
  }) async {
    const steps = 20; // Number of animation steps
    final stepDuration = Duration(
      milliseconds: duration.inMilliseconds ~/ steps,
    );

    // Cancel any existing animation
    _animationTimer?.cancel();

    // Emit animation steps
    for (int i = 0; i <= steps; i++) {
      final progress = i / steps;

      emit(
        PanelAnimating(
          toExpanded: toExpanded,
          progress: progress,
          duration: duration,
        ),
      );

      // Wait for next step (except on last step)
      if (i < steps) {
        await Future.delayed(stepDuration);
      }
    }

    // Emit final state
    if (toExpanded) {
      emit(
        PanelExpanded(
          panelWidth: _panelWidth,
          animate: true,
          animationDuration: duration,
        ),
      );
    } else {
      emit(PanelCollapsed(animate: true, animationDuration: duration));
    }
  }

  /// Helper method to determine default panel state based on screen width
  static bool shouldExpandByDefault(double screenWidth) {
    // Expand by default on larger screens
    if (screenWidth >= ResponsiveBreakpoints.largeTablet) {
      return true;
    } else if (screenWidth >= ResponsiveBreakpoints.mediumTablet) {
      return true;
    }
    // Collapse by default on smaller screens
    return false;
  }

  /// Get appropriate panel width for screen size
  static double getPanelWidthForScreen(double screenWidth) {
    if (screenWidth >= ResponsiveBreakpoints.extraLargeTablet) {
      return PanelConstants.leftPanelExtraLarge;
    } else if (screenWidth >= ResponsiveBreakpoints.largeTablet) {
      return PanelConstants.leftPanelLarge;
    } else if (screenWidth >= ResponsiveBreakpoints.mediumTablet) {
      return PanelConstants.leftPanelMedium;
    } else {
      return PanelConstants.leftPanelSmall;
    }
  }
}
