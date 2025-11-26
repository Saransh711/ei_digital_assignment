/// Guest list panel widget for the left side of the application
/// This widget displays the list of guests with search and filtering capabilities.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/ui_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../domain/entities/guest_entity.dart';
import '../bloc/guest_list_bloc/guest_list_bloc.dart';
import '../bloc/guest_list_bloc/guest_list_event.dart';
import '../bloc/guest_list_bloc/guest_list_state.dart';
import 'common/responsive_padding.dart';
import 'common/responsive_text.dart';
import 'guest_list_item.dart';

/// Panel widget containing the guest list
class GuestListPanel extends StatelessWidget {
  const GuestListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // If width is too small, return empty container to prevent overflow
        if (availableWidth < 150) {
          return const SizedBox.shrink();
        }

        return Container(
          color: AppColors.surface,
          width: availableWidth,
          constraints: BoxConstraints(minWidth: 0, maxWidth: availableWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Panel header
              _buildPanelHeader(context),

              // Search bar
              _buildSearchBar(context),

              // Guest list
              Expanded(child: _buildGuestList(context)),
            ],
          ),
        );
      },
    );
  }

  /// Build the panel header - matches screenshots exactly
  Widget _buildPanelHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Hide header if width is too small
        if (availableWidth < 100) {
          return const SizedBox.shrink();
        }

        final padding = availableWidth > 200
            ? context.responsivePadding(UIConstants.spacingM)
            : context.responsivePadding(UIConstants.spacingS);
        final spacing = availableWidth > 200
            ? context.responsivePadding(UIConstants.spacingM)
            : context.responsivePadding(UIConstants.spacingS);

        return Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: availableWidth),
          padding: EdgeInsets.all(padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                color: AppColors.darkSidebar,
                size: context.responsiveFontSize(24),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: ResponsiveText(
                  'Settings',
                  style: ResponsiveTextStyle.headlineMedium,
                  color: AppColors.darkSidebar,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build the search bar
  Widget _buildSearchBar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Hide search bar if width is too small
        if (availableWidth < 100) {
          return const SizedBox.shrink();
        }

        final horizontalPadding = availableWidth > 200
            ? context.responsivePadding(UIConstants.spacingM)
            : context.responsivePadding(UIConstants.spacingS);

        return Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: availableWidth),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: context.responsivePadding(UIConstants.spacingS),
          ),
          child: TextField(
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: context.responsiveFontSize(14),
            ),
            decoration: InputDecoration(
              hintText: 'Search guests...',
              hintStyle: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.6),
                fontSize: context.responsiveFontSize(14),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textPrimary.withValues(alpha: 0.6),
                size: context.responsiveFontSize(20),
              ),
              filled: true,
              fillColor: AppColors.surface.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.radiusM),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: context.responsivePadding(UIConstants.spacingS),
              ),
            ),
            onChanged: (query) {
              // Immediately clear search if query is empty, otherwise search
              if (query.trim().isEmpty) {
                context.read<GuestListBloc>().add(const ClearSearchEvent());
              } else {
                context.read<GuestListBloc>().add(
                  SearchGuestsEvent(query: query),
                );
              }
            },
          ),
        );
      },
    );
  }

  /// Build the guest list
  Widget _buildGuestList(BuildContext context) {
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        // Handle searching state - show previous guests if available while searching
        if (state is GuestListSearching) {
          // Try to get previous guests from any previous loaded state
          final previousGuests = _getPreviousGuests(context);
          if (previousGuests != null && previousGuests.isNotEmpty) {
            // Show previous guests while searching (better UX)
            return _buildLoadedList(
              context,
              GuestListLoaded(
                guests: previousGuests,
                searchQuery: state.query,
                isFiltered: true,
                totalGuestCount: previousGuests.length,
                lastUpdated: DateTime.now(),
              ),
            );
          }
          // Show minimal loading indicator only if no previous guests
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (state.isLoading && !state.hasGuestData) {
          return _buildLoadingList(context);
        }

        if (state.isError && !state.hasGuestData) {
          return _buildErrorState(context, state as GuestListError);
        }

        if (state.isLoaded) {
          final loadedState = state as GuestListLoaded;

          if (loadedState.guests.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildLoadedList(context, loadedState);
        }

        return _buildEmptyState(context);
      },
    );
  }

  /// Get previous guests from BLoC state for smooth transitions
  List<Guest>? _getPreviousGuests(BuildContext context) {
    final bloc = context.read<GuestListBloc>();
    final currentState = bloc.state;

    // Try to get guests from current state
    if (currentState is GuestListLoaded) {
      return currentState.guests;
    } else if (currentState is GuestListRefreshing) {
      return currentState.currentGuests;
    } else if (currentState is GuestListError) {
      return currentState.previousGuests;
    }

    // Fallback: get from bloc's internal cache if available
    try {
      return bloc.guests;
    } catch (e) {
      return null;
    }
  }

  /// Build loading list
  Widget _buildLoadingList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding(UIConstants.spacingS),
      ),
      itemCount: 1, // Show 6 loading items
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(
          vertical: context.responsivePadding(UIConstants.spacingXS),
        ),
        height: context.responsiveValue(
          small: 70.0,
          medium: 80.0,
          large: 90.0,
          extraLarge: 100.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
        ),
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(BuildContext context, GuestListError errorState) {
    return ResponsivePadding.large(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: context.responsiveFontSize(48),
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingM)),
          ResponsiveText(
            'Error Loading Guests',
            style: ResponsiveTextStyle.headlineSmall,
            color: AppColors.textPrimary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingS)),
          ResponsiveText(
            errorState.message,
            style: ResponsiveTextStyle.bodyMedium,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          if (errorState.canRetry) ...[
            SizedBox(height: context.responsivePadding(UIConstants.spacingL)),
            ElevatedButton(
              onPressed: () {
                context.read<GuestListBloc>().add(
                  const LoadGuestListEvent(forceRefresh: true),
                );
              },
              child: const ResponsiveText('Retry'),
            ),
          ],
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState(BuildContext context) {
    return ResponsivePadding.large(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            size: context.responsiveFontSize(48),
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingM)),
          ResponsiveText(
            'No Guests Found',
            style: ResponsiveTextStyle.headlineSmall,
            color: AppColors.textPrimary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingS)),
          ResponsiveText(
            'Try adjusting your search or filters',
            style: ResponsiveTextStyle.bodyMedium,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build loaded list
  Widget _buildLoadedList(BuildContext context, GuestListLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GuestListBloc>().add(const RefreshGuestListEvent());
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.guests.length,
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: AppColors.divider,
          margin: const EdgeInsets.only(left: 64),
        ),
        itemBuilder: (context, index) {
          final guest = state.guests[index];
          final isSelected = state.selectedGuest?.id == guest.id;

          return GuestListItem(
            guest: guest,
            isSelected: isSelected,
            onTap: () {
              context.read<GuestListBloc>().add(
                SelectGuestEvent(guestId: guest.id),
              );
            },
          );
        },
      ),
    );
  }
}
