/// Guest List BLoC for managing guest data and selection state
/// This BLoC handles all guest list operations including loading, searching,
/// filtering, sorting, and selection with proper error handling.
library;

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'guest_list_event.dart';
import 'guest_list_state.dart';
import '../../../domain/entities/guest_entity.dart';
import '../../../domain/usecases/get_guests_usecase.dart';
import '../../../core/error/failures.dart';

/// BLoC for managing guest list state and operations
/// Handles loading guests, search, filtering, sorting, and selection
/// with proper error handling and recovery mechanisms
class GuestListBloc extends Bloc<GuestListEvent, GuestListState> {
  /// Use case for retrieving guests
  final GetGuestsUseCase getGuestsUseCase;

  /// Timer for search debouncing
  Timer? _searchDebounceTimer;

  /// Duration to wait before executing search
  static const Duration _searchDebounceDelay = Duration(milliseconds: 300);

  /// Cache of all loaded guests (for filtering and searching)
  List<Guest> _allGuests = [];

  /// Creates a new GuestListBloc instance
  GuestListBloc({required this.getGuestsUseCase})
    : super(const GuestListInitial()) {
    // Register event handlers
    on<LoadGuestListEvent>(_onLoadGuestList);
    on<SearchGuestsEvent>(_onSearchGuests, transformer: _debounceTransformer());
    on<ClearSearchEvent>(_onClearSearch);
    on<SelectGuestEvent>(_onSelectGuest);
    on<DeselectGuestEvent>(_onDeselectGuest);
    on<FilterGuestsEvent>(_onFilterGuests);
    on<ClearFiltersEvent>(_onClearFilters);
    on<SortGuestsEvent>(_onSortGuests);
    on<RefreshGuestListEvent>(_onRefreshGuestList);
    on<LoadGuestsWithUpcomingVisitsEvent>(_onLoadGuestsWithUpcomingVisits);
    on<LoadGuestsWithAllergiesEvent>(_onLoadGuestsWithAllergies);
    on<LoadTopSpendingGuestsEvent>(_onLoadTopSpendingGuests);
  }

  // ========== PUBLIC GETTERS ==========

  /// Get currently loaded guests
  List<Guest> get guests => _allGuests;

  /// Get selected guest (if any)
  Guest? get selectedGuest => state.selectedGuest;

  /// Check if guests are currently loaded
  bool get hasGuests => _allGuests.isNotEmpty;

  /// Check if BLoC is in loading state
  bool get isLoading => state.isLoading;

  /// Check if BLoC is in error state
  bool get hasError => state.isError;

  // ========== EVENT HANDLERS ==========

  /// Handle loading guest list
  Future<void> _onLoadGuestList(
    LoadGuestListEvent event,
    Emitter<GuestListState> emit,
  ) async {
    // Skip loading if already loaded and not forcing refresh
    if (!event.forceRefresh && state is GuestListLoaded) {
      return;
    }

    emit(const GuestListLoading(loadingMessage: 'Loading guests...'));

    final result = await getGuestsUseCase();

    result.fold((failure) => emit(_mapFailureToErrorState(failure)), (guests) {
      _allGuests = guests;
      emit(
        GuestListLoaded(
          guests: guests,
          totalGuestCount: guests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }

  /// Handle guest search with debouncing
  Future<void> _onSearchGuests(
    SearchGuestsEvent event,
    Emitter<GuestListState> emit,
  ) async {
    final query = event.query.trim();

    // Handle empty search query immediately - don't emit searching state
    if (query.isEmpty) {
      // Always clear search immediately when query is empty
      if (state is GuestListLoaded) {
        final currentState = state as GuestListLoaded;
        List<Guest> filteredGuests;
        bool isFiltered = false;

        // Apply current filter (if any) to all guests, or show all guests
        if (currentState.hasFilter) {
          filteredGuests = _applyFilter(_allGuests, currentState.filter!);
          isFiltered = true;
        } else {
          filteredGuests = _allGuests;
        }

        // Apply current sort
        filteredGuests = _applySorting(
          filteredGuests,
          currentState.sortBy,
          currentState.sortOrder,
        );

        emit(
          currentState.copyWith(
            guests: filteredGuests,
            isFiltered: isFiltered,
            lastUpdated: DateTime.now(),
            clearSearchQuery: true,
          ),
        );
      } else {
        // If we're in searching or any other state, go directly to loaded
        emit(
          GuestListLoaded(
            guests: _allGuests,
            totalGuestCount: _allGuests.length,
            lastUpdated: DateTime.now(),
          ),
        );
      }
      return;
    }

    // Store the current query to check later if it's still valid
    final searchQuery = query;

    // Emit searching state only if query changed
    if (state is! GuestListSearching ||
        (state as GuestListSearching).query != searchQuery) {
      emit(GuestListSearching(query: searchQuery));
    }

    // Perform search on use case
    final result = await getGuestsUseCase.searchGuests(searchQuery);

    // Check if we're still in a state that expects this result
    // This prevents race conditions when user types/deletes quickly
    final currentState = state;
    if (currentState is GuestListSearching &&
        (currentState).query == searchQuery) {
      // We're still searching for this query, emit results
      result.fold((failure) => emit(_mapFailureToErrorState(failure)), (
        searchResults,
      ) {
        emit(
          GuestListLoaded(
            guests: searchResults,
            searchQuery: searchQuery,
            isFiltered: true,
            totalGuestCount: _allGuests.length,
            lastUpdated: DateTime.now(),
          ),
        );
      });
    } else if (currentState is GuestListLoaded) {
      // State changed (e.g., user cleared search), but we got results
      // Only update if the loaded state doesn't have a search query
      // or if it matches our search query
      if (!currentState.hasSearchQuery ||
          currentState.searchQuery == searchQuery) {
        result.fold(
          (failure) {
            // Don't emit error if state already changed
            if (currentState.searchQuery == searchQuery) {
              emit(_mapFailureToErrorState(failure));
            }
          },
          (searchResults) {
            emit(
              currentState.copyWith(
                guests: searchResults,
                searchQuery: searchQuery,
                isFiltered: true,
                lastUpdated: DateTime.now(),
              ),
            );
          },
        );
      }
    }
    // If state changed to something else (like cleared), ignore the result
  }

  /// Handle clearing search
  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<GuestListState> emit,
  ) async {
    // Handle clearing search from any state
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      // Apply current filter (if any) to all guests, or show all guests
      List<Guest> filteredGuests;
      bool isFiltered = false;

      if (currentState.hasFilter) {
        filteredGuests = _applyFilter(_allGuests, currentState.filter!);
        isFiltered = true;
      } else {
        filteredGuests = _allGuests;
      }

      // Apply current sort
      filteredGuests = _applySorting(
        filteredGuests,
        currentState.sortBy,
        currentState.sortOrder,
      );

      emit(
        currentState.copyWith(
          guests: filteredGuests,
          isFiltered: isFiltered,
          lastUpdated: DateTime.now(),
          clearSearchQuery: true,
        ),
      );
    } else if (state is GuestListSearching) {
      // If we're in searching state, immediately go to loaded with all guests
      emit(
        GuestListLoaded(
          guests: _allGuests,
          totalGuestCount: _allGuests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    } else {
      // For any other state, ensure we have a loaded state
      emit(
        GuestListLoaded(
          guests: _allGuests,
          totalGuestCount: _allGuests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  /// Handle guest selection
  Future<void> _onSelectGuest(
    SelectGuestEvent event,
    Emitter<GuestListState> emit,
  ) async {
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      // Find the guest in current list
      final selectedGuest = currentState.guests.firstWhere(
        (guest) => guest.id == event.guestId,
        orElse: () => throw StateError('Guest not found'),
      );

      emit(
        currentState.copyWith(
          selectedGuest: selectedGuest,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  /// Handle guest deselection
  Future<void> _onDeselectGuest(
    DeselectGuestEvent event,
    Emitter<GuestListState> emit,
  ) async {
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      emit(
        currentState.copyWith(
          clearSelectedGuest: true,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  /// Handle applying filters
  Future<void> _onFilterGuests(
    FilterGuestsEvent event,
    Emitter<GuestListState> emit,
  ) async {
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      // Apply filter to all guests
      final filteredGuests = _applyFilter(_allGuests, event.filter);

      // Apply current sort
      final sortedGuests = _applySorting(
        filteredGuests,
        currentState.sortBy,
        currentState.sortOrder,
      );

      emit(
        currentState.copyWith(
          guests: sortedGuests,
          filter: event.filter,
          isFiltered: event.filter.isNotEmpty,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  /// Handle clearing filters
  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<GuestListState> emit,
  ) async {
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      // Start with all guests or search results
      List<Guest> baseGuests = _allGuests;
      bool isFiltered = false;

      // Apply search if active
      if (currentState.hasSearchQuery) {
        final searchResult = await getGuestsUseCase.searchGuests(
          currentState.searchQuery!,
        );
        searchResult.fold((failure) => baseGuests = _allGuests, (
          searchResults,
        ) {
          baseGuests = searchResults;
          isFiltered = true;
        });
      }

      // Apply current sort
      final sortedGuests = _applySorting(
        baseGuests,
        currentState.sortBy,
        currentState.sortOrder,
      );

      emit(
        currentState.copyWith(
          guests: sortedGuests,
          isFiltered: isFiltered,
          lastUpdated: DateTime.now(),
          clearFilter: true,
        ),
      );
    }
  }

  /// Handle sorting guests
  Future<void> _onSortGuests(
    SortGuestsEvent event,
    Emitter<GuestListState> emit,
  ) async {
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;

      // Apply sort to current guest list
      final sortedGuests = _applySorting(
        currentState.guests,
        event.sortBy,
        event.sortOrder,
      );

      emit(
        currentState.copyWith(
          guests: sortedGuests,
          sortBy: event.sortBy,
          sortOrder: event.sortOrder,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  /// Handle refreshing guest list
  Future<void> _onRefreshGuestList(
    RefreshGuestListEvent event,
    Emitter<GuestListState> emit,
  ) async {
    // Emit refreshing state with current guests
    if (state is GuestListLoaded) {
      final currentState = state as GuestListLoaded;
      emit(GuestListRefreshing(currentGuests: currentState.guests));
    } else {
      emit(
        const GuestListLoading(
          loadingMessage: 'Refreshing guests...',
          isRefreshing: true,
        ),
      );
    }

    // Load fresh data
    final result = await getGuestsUseCase();

    result.fold((failure) => emit(_mapFailureToErrorState(failure)), (guests) {
      _allGuests = guests;
      emit(
        GuestListLoaded(
          guests: guests,
          totalGuestCount: guests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }

  /// Handle loading guests with upcoming visits
  Future<void> _onLoadGuestsWithUpcomingVisits(
    LoadGuestsWithUpcomingVisitsEvent event,
    Emitter<GuestListState> emit,
  ) async {
    emit(
      const GuestListLoading(
        loadingMessage: 'Loading guests with upcoming visits...',
      ),
    );

    final result = await getGuestsUseCase.getGuestsWithUpcomingVisits();

    result.fold((failure) => emit(_mapFailureToErrorState(failure)), (guests) {
      emit(
        GuestListLoaded(
          guests: guests,
          filter: const GuestFilter(hasUpcomingVisits: true),
          isFiltered: true,
          totalGuestCount: _allGuests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }

  /// Handle loading guests with allergies
  Future<void> _onLoadGuestsWithAllergies(
    LoadGuestsWithAllergiesEvent event,
    Emitter<GuestListState> emit,
  ) async {
    emit(
      const GuestListLoading(
        loadingMessage: 'Loading guests with allergies...',
      ),
    );

    final result = await getGuestsUseCase.getGuestsWithAllergies();

    result.fold((failure) => emit(_mapFailureToErrorState(failure)), (guests) {
      emit(
        GuestListLoaded(
          guests: guests,
          filter: const GuestFilter(hasAllergies: true),
          isFiltered: true,
          totalGuestCount: _allGuests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }

  /// Handle loading top spending guests
  Future<void> _onLoadTopSpendingGuests(
    LoadTopSpendingGuestsEvent event,
    Emitter<GuestListState> emit,
  ) async {
    emit(
      const GuestListLoading(loadingMessage: 'Loading top spending guests...'),
    );

    final result = await getGuestsUseCase.getTopSpendingGuests(
      limit: event.limit,
    );

    result.fold((failure) => emit(_mapFailureToErrorState(failure)), (guests) {
      emit(
        GuestListLoaded(
          guests: guests,
          sortBy: GuestSortBy.lifetimeSpend,
          sortOrder: SortOrder.descending,
          isFiltered: true,
          totalGuestCount: _allGuests.length,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }

  // ========== PRIVATE HELPER METHODS ==========

  /// Apply filter to guest list
  List<Guest> _applyFilter(List<Guest> guests, GuestFilter filter) {
    return guests.where((guest) {
      // Filter by allergies
      if (filter.hasAllergies != null) {
        if (filter.hasAllergies! && !guest.hasAllergies) return false;
        if (!filter.hasAllergies! && guest.hasAllergies) return false;
      }

      // Filter by upcoming visits
      if (filter.hasUpcomingVisits != null) {
        if (filter.hasUpcomingVisits! && !guest.hasUpcomingVisits) return false;
        if (!filter.hasUpcomingVisits! && guest.hasUpcomingVisits) return false;
      }

      // Filter by tags
      if (filter.tags != null && filter.tags!.isNotEmpty) {
        final hasAnyTag = filter.tags!.any((tag) => guest.tags.contains(tag));
        if (!hasAnyTag) return false;
      }

      return true;
    }).toList();
  }

  /// Apply sorting to guest list
  List<Guest> _applySorting(
    List<Guest> guests,
    GuestSortBy sortBy,
    SortOrder sortOrder,
  ) {
    final sortedGuests = List<Guest>.from(guests);

    sortedGuests.sort((a, b) {
      int comparison = 0;

      switch (sortBy) {
        case GuestSortBy.name:
          comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case GuestSortBy.email:
          comparison = a.email.toLowerCase().compareTo(b.email.toLowerCase());
          break;
        case GuestSortBy.lastVisit:
          final aDate = a.lastVisit ?? DateTime(1900);
          final bDate = b.lastVisit ?? DateTime(1900);
          comparison = aDate.compareTo(bDate);
          break;
        case GuestSortBy.totalVisits:
          comparison = a.totalVisits.compareTo(b.totalVisits);
          break;
        case GuestSortBy.lifetimeSpend:
          comparison = a.lifetimeSpend.compareTo(b.lifetimeSpend);
          break;
        case GuestSortBy.customerSince:
          final aDate = a.customerSince ?? DateTime(1900);
          final bDate = b.customerSince ?? DateTime(1900);
          comparison = aDate.compareTo(bDate);
          break;
        case GuestSortBy.upcomingVisits:
          comparison = a.upcomingVisits.compareTo(b.upcomingVisits);
          break;
      }

      return sortOrder == SortOrder.ascending ? comparison : -comparison;
    });

    return sortedGuests;
  }

  /// Map failure to appropriate error state
  GuestListError _mapFailureToErrorState(Failure failure) {
    String userMessage;
    bool canRetry = true;

    if (failure is NetworkFailure) {
      userMessage =
          'Network error. Please check your connection and try again.';
    } else if (failure is DataSourceFailure) {
      userMessage = 'Unable to load guest data. Please try again.';
    } else if (failure is ValidationFailure) {
      userMessage = failure.message;
      canRetry = false;
    } else {
      userMessage = 'An unexpected error occurred. Please try again.';
    }

    return GuestListError(
      message: userMessage,
      technicalDetails: failure.message,
      errorCode: failure.code,
      canRetry: canRetry,
      previousGuests: _allGuests.isNotEmpty ? _allGuests : null,
      timestamp: DateTime.now(),
    );
  }

  /// Debounce transformer for search events
  EventTransformer<SearchGuestsEvent> _debounceTransformer() {
    return (events, mapper) {
      return events.debounceTime(_searchDebounceDelay).switchMap(mapper);
    };
  }

  /// Dispose resources when BLoC is closed
  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}

/// Extension for stream debouncing
extension _StreamExtension<T> on Stream<T> {
  Stream<T> debounceTime(Duration duration) {
    StreamSubscription<T>? subscription;
    late StreamController<T> controller;

    controller = StreamController<T>(
      onListen: () {
        subscription = listen(
          (data) {
            Timer(duration, () {
              if (!controller.isClosed) {
                controller.add(data);
              }
            });
          },
          onError: controller.addError,
          onDone: controller.close,
        );
      },
      onCancel: () => subscription?.cancel(),
    );

    return controller.stream;
  }

  Stream<S> switchMap<S>(Stream<S> Function(T) mapper) {
    StreamSubscription<S>? innerSubscription;
    late StreamController<S> controller;

    controller = StreamController<S>(
      onListen: () {
        listen(
          (data) {
            innerSubscription?.cancel();
            innerSubscription = mapper(data).listen(
              controller.add,
              onError: controller.addError,
              onDone: () {},
            );
          },
          onError: controller.addError,
          onDone: () {
            innerSubscription?.cancel();
            controller.close();
          },
        );
      },
      onCancel: () => innerSubscription?.cancel(),
    );

    return controller.stream;
  }
}
