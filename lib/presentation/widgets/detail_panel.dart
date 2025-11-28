import 'package:ei_digital_assignment/core/di/injection_container.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_event.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_state.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_event.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/detail_empty_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/guest_detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPanel extends StatefulWidget {
  const DetailPanel({super.key});

  @override
  State<DetailPanel> createState() => _DetailPanelState();
}

class _DetailPanelState extends State<DetailPanel> {
  bool _hasAutoSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (context) => sl<TabBloc>()..add(const InitializeTabsEvent()),
      child: BlocBuilder<GuestListBloc, GuestListState>(
        builder: (context, state) {
          if (state.isLoaded) {
            final loadedState = state as GuestListLoaded;

            // Auto-select first guest if list is loaded and no guest is selected
            // Only do this once to prevent multiple selections
            if (!loadedState.hasSelectedGuest &&
                loadedState.hasGuests &&
                !_hasAutoSelected) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !_hasAutoSelected) {
                  _hasAutoSelected = true;
                  final firstGuest = loadedState.guests.first;
                  context.read<GuestListBloc>().add(
                    SelectGuestEvent(guestId: firstGuest.id),
                  );
                }
              });
              // Show message while selecting first guest instead of loader
              return const DetailEmptyState(
                message: 'Loading guest details...',
              );
            }

            if (loadedState.hasSelectedGuest) {
              // Panel is open - show guest detail
              return GuestDetailPanel(guest: loadedState.selectedGuest!);
            }

            // If no guests available, show message instead of loader
            if (!loadedState.hasGuests) {
              return const DetailEmptyState(
                message:
                    'No guests available. Please add guests to view details.',
              );
            }
          }

          // Show message while loading or if state is not loaded
          if (state.isLoading) {
            return const DetailEmptyState(message: 'Loading guests...');
          }

          // Default empty state
          return const DetailEmptyState();
        },
      ),
    );
  }
}
