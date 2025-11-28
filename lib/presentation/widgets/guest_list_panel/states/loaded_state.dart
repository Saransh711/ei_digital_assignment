import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_event.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/guest_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Loaded state widget showing the list of guests
class GuestListLoadedState extends StatelessWidget {
  final GuestListLoaded state;

  const GuestListLoadedState({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.guests.length,
      separatorBuilder: (context, index) =>
          Container(height: 2, color: AppColors.divider),
      itemBuilder: (context, index) {
        final guest = state.guests[index];
        final isSelected = state.selectedGuest?.id == guest.id;

        return GuestListItem(
          guest: guest,
          isSelected: isSelected,
          showDetails: true,
          onTap: () {
            context.read<GuestListBloc>().add(
              SelectGuestEvent(guestId: guest.id),
            );
          },
        );
      },
    );
  }
}
