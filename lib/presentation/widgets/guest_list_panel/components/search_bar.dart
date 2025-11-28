import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Search bar component for guest list
class GuestSearchBar extends StatelessWidget {
  const GuestSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              hintText: 'Search...',
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
}
