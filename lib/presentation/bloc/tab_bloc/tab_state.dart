/// States for Tab BLoC
/// These states represent the current tab selection
library;

import 'package:equatable/equatable.dart';

/// Base class for all tab states
abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object?> get props => [];
}

/// Initial state of tabs
class TabInitial extends TabState {
  const TabInitial();

  @override
  String toString() => 'TabInitial';
}

/// State when a tab is selected
class TabSelected extends TabState {
  final int selectedTabIndex;

  const TabSelected(this.selectedTabIndex);

  @override
  List<Object?> get props => [selectedTabIndex];

  @override
  String toString() => 'TabSelected(selectedTabIndex: $selectedTabIndex)';
}

/// Extension for easy access to selected tab index
extension TabStateExtension on TabState {
  int? get selectedTabIndex {
    if (this is TabSelected) {
      return (this as TabSelected).selectedTabIndex;
    }
    return null;
  }
}