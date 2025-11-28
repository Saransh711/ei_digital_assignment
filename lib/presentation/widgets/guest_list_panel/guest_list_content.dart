import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/states/empty_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/states/error_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/states/loaded_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/states/loading_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/states/search_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Guest list content that handles different states
class GuestListContent extends StatelessWidget {
  const GuestListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestListBloc, GuestListState>(
      builder: (context, state) {
        if (state is GuestListSearching) {
          final previousGuests = _getPreviousGuests(context);
          if (previousGuests != null && previousGuests.isNotEmpty) {
            return GuestListLoadedState(
              state: GuestListLoaded(
                guests: previousGuests,
                searchQuery: state.query,
                isFiltered: true,
                totalGuestCount: previousGuests.length,
                lastUpdated: DateTime.now(),
              ),
            );
          }

          return GuestListSearchEmptyState(searchQuery: state.query);
        }

        if (state.isLoading && !state.hasGuestData) {
          return const GuestListLoadingState();
        }

        if (state.isError && !state.hasGuestData) {
          return GuestListErrorState(errorState: state as GuestListError);
        }

        if (state.isLoaded) {
          final loadedState = state as GuestListLoaded;

          if (loadedState.guests.isEmpty) {
            if (loadedState.hasSearchQuery) {
              return GuestListSearchEmptyState(
                searchQuery: loadedState.searchQuery,
              );
            }
            return const GuestListEmptyState();
          }

          return GuestListLoadedState(state: loadedState);
        }

        return const GuestListEmptyState();
      },
    );
  }

  List<Guest>? _getPreviousGuests(BuildContext context) {
    final bloc = context.read<GuestListBloc>();
    final currentState = bloc.state;

    if (currentState is GuestListLoaded) {
      return currentState.guests;
    } else if (currentState is GuestListRefreshing) {
      return currentState.currentGuests;
    } else if (currentState is GuestListError) {
      return currentState.previousGuests;
    }

    try {
      return bloc.guests;
    } catch (e) {
      return null;
    }
  }
}
