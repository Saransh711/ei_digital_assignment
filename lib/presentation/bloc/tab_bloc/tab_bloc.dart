/// Tab BLoC for managing tab navigation state
/// This BLoC handles tab selection and navigation
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'tab_event.dart';
import 'tab_state.dart';

/// BLoC for managing tab navigation state
class TabBloc extends Bloc<TabEvent, TabState> {
  /// Creates a new TabBloc instance
  TabBloc() : super(const TabInitial()) {
    on<InitializeTabsEvent>(_onInitializeTabs);
    on<SelectTabEvent>(_onSelectTab);
  }

  /// Handle tab initialization
  void _onInitializeTabs(
    InitializeTabsEvent event,
    Emitter<TabState> emit,
  ) {
    // Start with first tab selected (Profile)
    emit(const TabSelected(0));
  }

  /// Handle tab selection
  void _onSelectTab(
    SelectTabEvent event,
    Emitter<TabState> emit,
  ) {
    emit(TabSelected(event.tabIndex));
  }
}