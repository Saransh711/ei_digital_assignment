/// States for Guest List BLoC
/// These states represent all possible states of the guest list
/// (loading, loaded, error, searching, filtered).
library;

import 'package:equatable/equatable.dart';
import '../../../domain/entities/guest_entity.dart';
import 'guest_list_event.dart';

/// Base class for all guest list states
/// All guest list states extend this class for type safety and equality comparison
abstract class GuestListState extends Equatable {
  const GuestListState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the guest list
/// Used when the BLoC is first created and no data has been loaded
class GuestListInitial extends GuestListState {
  const GuestListInitial();

  @override
  String toString() => 'GuestListInitial';
}

/// State when guest data is being loaded
/// Shows loading indicators in the UI
class GuestListLoading extends GuestListState {
  /// Message to display during loading (optional)
  final String? loadingMessage;

  /// Whether this is a refresh operation
  final bool isRefreshing;

  const GuestListLoading({
    this.loadingMessage,
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [loadingMessage, isRefreshing];

  @override
  String toString() => 'GuestListLoading(message: "$loadingMessage", isRefreshing: $isRefreshing)';
}

/// State when guest data has been successfully loaded
/// Contains the list of guests and related metadata
class GuestListLoaded extends GuestListState {
  /// List of all loaded guests
  final List<Guest> guests;

  /// Currently selected guest (if any)
  final Guest? selectedGuest;

  /// Current search query (if any)
  final String? searchQuery;

  /// Applied filters (if any)
  final GuestFilter? filter;

  /// Current sort criteria
  final GuestSortBy sortBy;

  /// Current sort order
  final SortOrder sortOrder;

  /// Whether the list has been searched/filtered
  final bool isFiltered;

  /// Total count of guests before filtering
  final int totalGuestCount;

  /// Timestamp of when data was last loaded
  final DateTime lastUpdated;

  const GuestListLoaded({
    required this.guests,
    this.selectedGuest,
    this.searchQuery,
    this.filter,
    this.sortBy = GuestSortBy.name,
    this.sortOrder = SortOrder.ascending,
    this.isFiltered = false,
    required this.totalGuestCount,
    required this.lastUpdated,
  });

  /// Create a copy of this state with updated values
  GuestListLoaded copyWith({
    List<Guest>? guests,
    Guest? selectedGuest,
    String? searchQuery,
    GuestFilter? filter,
    GuestSortBy? sortBy,
    SortOrder? sortOrder,
    bool? isFiltered,
    int? totalGuestCount,
    DateTime? lastUpdated,
    bool clearSelectedGuest = false,
    bool clearSearchQuery = false,
    bool clearFilter = false,
  }) {
    return GuestListLoaded(
      guests: guests ?? this.guests,
      selectedGuest: clearSelectedGuest ? null : (selectedGuest ?? this.selectedGuest),
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
      filter: clearFilter ? null : (filter ?? this.filter),
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      isFiltered: isFiltered ?? this.isFiltered,
      totalGuestCount: totalGuestCount ?? this.totalGuestCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Check if there are any guests in the list
  bool get hasGuests => guests.isNotEmpty;

  /// Check if a guest is currently selected
  bool get hasSelectedGuest => selectedGuest != null;

  /// Check if search is active
  bool get hasSearchQuery => searchQuery != null && searchQuery!.isNotEmpty;

  /// Check if filters are applied
  bool get hasFilter => filter != null && filter!.isNotEmpty;

  /// Get the count of displayed guests (after filtering/searching)
  int get displayedGuestCount => guests.length;

  /// Check if the list is showing all guests (no search/filter)
  bool get showingAllGuests => !hasSearchQuery && !hasFilter;

  @override
  List<Object?> get props => [
        guests,
        selectedGuest,
        searchQuery,
        filter,
        sortBy,
        sortOrder,
        isFiltered,
        totalGuestCount,
        lastUpdated,
      ];

  @override
  String toString() {
    return 'GuestListLoaded(guests: ${guests.length}, selectedGuest: ${selectedGuest?.name}, '
        'searchQuery: "$searchQuery", filter: $filter, sortBy: $sortBy, sortOrder: $sortOrder, '
        'isFiltered: $isFiltered, totalCount: $totalGuestCount, lastUpdated: $lastUpdated)';
  }
}

/// State when an error occurs while loading guest data
/// Contains error information for display and recovery options
class GuestListError extends GuestListState {
  /// Error message to display to the user
  final String message;

  /// Technical error details for debugging
  final String? technicalDetails;

  /// Error code for programmatic handling
  final String? errorCode;

  /// Whether the error is recoverable (can retry)
  final bool canRetry;

  /// Previously loaded data (if any) to show during error
  final List<Guest>? previousGuests;

  /// Timestamp when the error occurred
  final DateTime timestamp;

  const GuestListError({
    required this.message,
    this.technicalDetails,
    this.errorCode,
    this.canRetry = true,
    this.previousGuests,
    required this.timestamp,
  });

  /// Check if there is previous data to fall back on
  bool get hasPreviousData => previousGuests != null && previousGuests!.isNotEmpty;

  @override
  List<Object?> get props => [
        message,
        technicalDetails,
        errorCode,
        canRetry,
        previousGuests,
        timestamp,
      ];

  @override
  String toString() {
    return 'GuestListError(message: "$message", errorCode: "$errorCode", '
        'canRetry: $canRetry, hasPreviousData: $hasPreviousData, timestamp: $timestamp)';
  }
}

/// State when searching guests
/// Used to show search-specific loading states
class GuestListSearching extends GuestListState {
  /// Search query being processed
  final String query;

  /// Progress of the search (0.0 to 1.0)
  final double? progress;

  const GuestListSearching({
    required this.query,
    this.progress,
  });

  @override
  List<Object?> get props => [query, progress];

  @override
  String toString() => 'GuestListSearching(query: "$query", progress: $progress)';
}

/// State when refreshing guest data
/// Used for pull-to-refresh operations
class GuestListRefreshing extends GuestListState {
  /// Current guests being displayed during refresh
  final List<Guest> currentGuests;

  /// Progress of the refresh operation (0.0 to 1.0)
  final double? progress;

  const GuestListRefreshing({
    required this.currentGuests,
    this.progress,
  });

  @override
  List<Object?> get props => [currentGuests, progress];

  @override
  String toString() => 'GuestListRefreshing(currentGuests: ${currentGuests.length}, progress: $progress)';
}

// ========== STATE EXTENSIONS ==========

/// Extension methods for guest list state convenience
extension GuestListStateExtensions on GuestListState {
  /// Check if the state contains guest data
  bool get hasGuestData => this is GuestListLoaded || this is GuestListRefreshing;

  /// Get guests from the current state (if available)
  List<Guest>? get guests {
    if (this is GuestListLoaded) {
      return (this as GuestListLoaded).guests;
    } else if (this is GuestListRefreshing) {
      return (this as GuestListRefreshing).currentGuests;
    } else if (this is GuestListError) {
      return (this as GuestListError).previousGuests;
    }
    return null;
  }

  /// Get selected guest from the current state (if available)
  Guest? get selectedGuest {
    if (this is GuestListLoaded) {
      return (this as GuestListLoaded).selectedGuest;
    }
    return null;
  }

  /// Check if the state is in a loading state
  bool get isLoading => 
      this is GuestListLoading || 
      this is GuestListSearching || 
      this is GuestListRefreshing;

  /// Check if the state represents an error
  bool get isError => this is GuestListError;

  /// Check if the state represents loaded data
  bool get isLoaded => this is GuestListLoaded;

  /// Check if the state is initial
  bool get isInitial => this is GuestListInitial;

  /// Get error message if state is error
  String? get errorMessage {
    if (this is GuestListError) {
      return (this as GuestListError).message;
    }
    return null;
  }

  /// Check if retry is possible
  bool get canRetry {
    if (this is GuestListError) {
      return (this as GuestListError).canRetry;
    }
    return false;
  }
}
