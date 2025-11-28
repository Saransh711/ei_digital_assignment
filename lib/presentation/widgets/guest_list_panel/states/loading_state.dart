import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

/// Loading state widget for guest list
class GuestListLoadingState extends StatelessWidget {
  const GuestListLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding(UIConstants.spacingS),
      ),
      itemCount: 1, // Show 1 loading item
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
}

