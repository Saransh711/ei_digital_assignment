import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Panel header with back button and settings text
class PanelHeader extends StatelessWidget {
  const PanelHeader({super.key});

  @override
  Widget build(BuildContext context) {
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

        return Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: availableWidth),
          padding: EdgeInsets.all(padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
}
