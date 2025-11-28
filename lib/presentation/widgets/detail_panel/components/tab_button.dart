import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_event.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Individual tab button widget
class TabButton extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;

  const TabButton({
    super.key,
    required this.title,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<TabBloc>().add(SelectTabEvent(index)),
      borderRadius: BorderRadius.circular(
        context.responsiveValue(
          small: 20,
          medium: 22,
          large: 24,
          extraLarge: 26,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsivePadding(20),
          vertical: context.responsivePadding(8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.detailPanelColor : Colors.transparent,
          borderRadius: BorderRadius.circular(
            context.responsiveValue(
              small: 20,
              medium: 22,
              large: 24,
              extraLarge: 26,
            ),
          ),
        ),
        child: ResponsiveText(
          title,
          style: ResponsiveTextStyle.bodyMedium,
          color: isSelected
              ? AppColors.surface
              : AppColors.detailPanelTextColor,
          fontWeight: FontWeight.bold,
          fontSize: context.responsiveFontSize(14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
