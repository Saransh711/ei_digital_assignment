/// Events for Tab BLoC
/// These events handle tab navigation and state management
library;

import 'package:equatable/equatable.dart';

/// Base class for all tab events
abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize tabs
class InitializeTabsEvent extends TabEvent {
  const InitializeTabsEvent();

  @override
  String toString() => 'InitializeTabsEvent';
}

/// Event to select a specific tab
class SelectTabEvent extends TabEvent {
  final int tabIndex;

  const SelectTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];

  @override
  String toString() => 'SelectTabEvent(tabIndex: $tabIndex)';
}