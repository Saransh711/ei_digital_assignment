/// Events for Guest List BLoC
/// These events represent all possible user actions that can affect
/// the guest list state (loading, searching, selecting).
library;

import 'package:equatable/equatable.dart';

/// Base class for all guest list events
/// All guest list events extend this class for type safety and equality comparison
abstract class GuestListEvent extends Equatable {
  const GuestListEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all guests from the repository
/// Triggered when the guest list screen is first opened
/// or when data needs to be refreshed
class LoadGuestListEvent extends GuestListEvent {
  /// Whether to force refresh from data source
  final bool forceRefresh;

  const LoadGuestListEvent({
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [forceRefresh];

  @override
  String toString() => 'LoadGuestListEvent(forceRefresh: $forceRefresh)';
}

/// Event to search guests by name or email
/// Triggered when user types in the search field
class SearchGuestsEvent extends GuestListEvent {
  /// Search query string
  final String query;

  const SearchGuestsEvent({
    required this.query,
  });

  @override
  List<Object?> get props => [query];

  @override
  String toString() => 'SearchGuestsEvent(query: "$query")';
}

/// Event to clear the current search
/// Triggered when user clears the search field
class ClearSearchEvent extends GuestListEvent {
  const ClearSearchEvent();

  @override
  String toString() => 'ClearSearchEvent';
}

/// Event to select a specific guest
/// Triggered when user taps on a guest list item
class SelectGuestEvent extends GuestListEvent {
  /// ID of the guest to select
  final String guestId;

  const SelectGuestEvent({
    required this.guestId,
  });

  @override
  List<Object?> get props => [guestId];

  @override
  String toString() => 'SelectGuestEvent(guestId: "$guestId")';
}

/// Event to deselect the currently selected guest
/// Triggered when user wants to clear the selection
class DeselectGuestEvent extends GuestListEvent {
  const DeselectGuestEvent();

  @override
  String toString() => 'DeselectGuestEvent';
}

/// Event to filter guests by specific criteria
/// Triggered when user applies filters to the guest list
class FilterGuestsEvent extends GuestListEvent {
  /// Filter criteria to apply
  final GuestFilter filter;

  const FilterGuestsEvent({
    required this.filter,
  });

  @override
  List<Object?> get props => [filter];

  @override
  String toString() => 'FilterGuestsEvent(filter: $filter)';
}

/// Event to clear all applied filters
/// Triggered when user wants to see all guests
class ClearFiltersEvent extends GuestListEvent {
  const ClearFiltersEvent();

  @override
  String toString() => 'ClearFiltersEvent';
}

/// Event to sort guests by specific criteria
/// Triggered when user changes the sort order
class SortGuestsEvent extends GuestListEvent {
  /// Sort criteria to apply
  final GuestSortBy sortBy;

  /// Sort order (ascending/descending)
  final SortOrder sortOrder;

  const SortGuestsEvent({
    required this.sortBy,
    this.sortOrder = SortOrder.ascending,
  });

  @override
  List<Object?> get props => [sortBy, sortOrder];

  @override
  String toString() => 'SortGuestsEvent(sortBy: $sortBy, sortOrder: $sortOrder)';
}

/// Event to refresh guest data
/// Triggered by pull-to-refresh or manual refresh action
class RefreshGuestListEvent extends GuestListEvent {
  const RefreshGuestListEvent();

  @override
  String toString() => 'RefreshGuestListEvent';
}

/// Event to load guests with upcoming visits
/// Triggered when user wants to see only guests with upcoming visits
class LoadGuestsWithUpcomingVisitsEvent extends GuestListEvent {
  const LoadGuestsWithUpcomingVisitsEvent();

  @override
  String toString() => 'LoadGuestsWithUpcomingVisitsEvent';
}

/// Event to load guests with allergies
/// Triggered when user wants to see only guests with allergies
class LoadGuestsWithAllergiesEvent extends GuestListEvent {
  const LoadGuestsWithAllergiesEvent();

  @override
  String toString() => 'LoadGuestsWithAllergiesEvent';
}

/// Event to load top spending guests
/// Triggered when user wants to see the highest spending guests
class LoadTopSpendingGuestsEvent extends GuestListEvent {
  /// Maximum number of guests to return
  final int limit;

  const LoadTopSpendingGuestsEvent({
    this.limit = 10,
  });

  @override
  List<Object?> get props => [limit];

  @override
  String toString() => 'LoadTopSpendingGuestsEvent(limit: $limit)';
}

// ========== HELPER CLASSES ==========

/// Guest filter criteria
class GuestFilter extends Equatable {
  /// Filter by visit frequency
  final String? visitFrequency;

  /// Filter by spending category
  final String? spendingCategory;

  /// Filter by allergy presence
  final bool? hasAllergies;

  /// Filter by upcoming visits
  final bool? hasUpcomingVisits;

  /// Filter by tags
  final List<String>? tags;

  /// Date range for filtering
  final DateRange? dateRange;

  const GuestFilter({
    this.visitFrequency,
    this.spendingCategory,
    this.hasAllergies,
    this.hasUpcomingVisits,
    this.tags,
    this.dateRange,
  });

  /// Create an empty filter (no filtering applied)
  const GuestFilter.empty()
      : visitFrequency = null,
        spendingCategory = null,
        hasAllergies = null,
        hasUpcomingVisits = null,
        tags = null,
        dateRange = null;

  /// Check if this filter has any criteria applied
  bool get isEmpty =>
      visitFrequency == null &&
      spendingCategory == null &&
      hasAllergies == null &&
      hasUpcomingVisits == null &&
      (tags == null || tags!.isEmpty) &&
      dateRange == null;

  /// Check if this filter has any criteria applied
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        visitFrequency,
        spendingCategory,
        hasAllergies,
        hasUpcomingVisits,
        tags,
        dateRange,
      ];

  @override
  String toString() {
    return 'GuestFilter(visitFrequency: $visitFrequency, spendingCategory: $spendingCategory, '
        'hasAllergies: $hasAllergies, hasUpcomingVisits: $hasUpcomingVisits, '
        'tags: $tags, dateRange: $dateRange)';
  }
}

/// Date range for filtering
class DateRange extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const DateRange({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];

  @override
  String toString() => 'DateRange(start: $startDate, end: $endDate)';
}

/// Guest sorting criteria
enum GuestSortBy {
  name,
  email,
  lastVisit,
  totalVisits,
  lifetimeSpend,
  customerSince,
  upcomingVisits,
}

/// Sort order enumeration
enum SortOrder {
  ascending,
  descending,
}

/// Extension for GuestSortBy display names
extension GuestSortByExtension on GuestSortBy {
  String get displayName {
    switch (this) {
      case GuestSortBy.name:
        return 'Name';
      case GuestSortBy.email:
        return 'Email';
      case GuestSortBy.lastVisit:
        return 'Last Visit';
      case GuestSortBy.totalVisits:
        return 'Total Visits';
      case GuestSortBy.lifetimeSpend:
        return 'Lifetime Spending';
      case GuestSortBy.customerSince:
        return 'Customer Since';
      case GuestSortBy.upcomingVisits:
        return 'Upcoming Visits';
    }
  }
}

/// Extension for SortOrder display names
extension SortOrderExtension on SortOrder {
  String get displayName {
    switch (this) {
      case SortOrder.ascending:
        return 'Ascending';
      case SortOrder.descending:
        return 'Descending';
    }
  }
}
