import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_event.dart';
import 'package:ei_digital_assignment/presentation/bloc/guest_list_bloc/guest_list_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_padding.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Error state widget for guest list
class GuestListErrorState extends StatelessWidget {
  final GuestListError errorState;

  const GuestListErrorState({
    super.key,
    required this.errorState,
  });

  @override
  Widget build(BuildContext context) {
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
}

