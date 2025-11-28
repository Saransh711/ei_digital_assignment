import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Empty state for detail panel when no guest is selected or available
class DetailEmptyState extends StatelessWidget {
  final String message;

  const DetailEmptyState({
    super.key,
    this.message = 'Select a guest to view details',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveText(
        message,
        style: ResponsiveTextStyle.headlineMedium,
        color: AppColors.textSecondary,
        textAlign: TextAlign.center,
      ),
    );
  }
}

