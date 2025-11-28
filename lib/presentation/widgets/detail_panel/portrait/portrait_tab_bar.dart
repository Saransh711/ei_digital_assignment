import 'package:ei_digital_assignment/core/constants/app_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Portrait orientation tab bar
class PortraitTabBar extends StatelessWidget {
  const PortraitTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        final selectedIndex = state.selectedTabIndex ?? 0;

        return Center(
          child: Container(
            margin: EdgeInsets.only(
              bottom: context.responsivePadding(16),
              left: context.responsivePadding(16),
              right: context.responsivePadding(16),
            ),
            padding: EdgeInsets.all(context.responsivePadding(4)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                context.responsiveValue(
                  small: 25,
                  medium: 28,
                  large: 30,
                  extraLarge: 32,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  AppConstants.navigationTabs.length,
                  (index) => TabButton(
                    title: AppConstants.navigationTabs[index],
                    index: index,
                    isSelected: selectedIndex == index,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
