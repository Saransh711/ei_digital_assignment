import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/empty_states_row.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/form_fields.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/metric_grids.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/profile_left_column.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/stats_strip.dart';
import 'package:flutter/material.dart';

abstract class MainSummaryCard extends StatelessWidget {
  final Guest guest;
  final bool isLandscape;

  const MainSummaryCard({
    super.key,
    required this.guest,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final double cardRadius = context
        .responsiveValue(small: 10, medium: 11, large: 12, extraLarge: 13)
        .toDouble();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: context.responsiveValue(
              small: 12,
              medium: 13,
              large: 15,
              extraLarge: 17,
            ),
            offset: Offset(
              0,
              context.responsiveValue(
                small: 4,
                medium: 5,
                large: 5,
                extraLarge: 6,
              ),
            ),
          ),
        ],
      ),
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context);
}

/// Portrait version of main summary card
class PortraitMainSummaryCard extends MainSummaryCard {
  const PortraitMainSummaryCard({super.key, required super.guest})
    : super(isLandscape: false);

  @override
  Widget buildContent(BuildContext context) {
    final sectionGap = context.responsivePadding(24);

    return Padding(
      padding: EdgeInsets.all(context.responsivePadding(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileLeftColumn(guest: guest),
          SizedBox(height: sectionGap),
          StatsStrip(isLandscape: isLandscape),
          SizedBox(height: sectionGap),
          FormFields(),
          SizedBox(height: sectionGap),
          MetricGrids(),
          SizedBox(height: sectionGap),
          EmptyStatesRow(isLandscape: isLandscape),
        ],
      ),
    );
  }
}

/// Landscape version of main summary card
class LandscapeMainSummaryCard extends MainSummaryCard {
  const LandscapeMainSummaryCard({super.key, required super.guest})
    : super(isLandscape: true);

  @override
  Widget buildContent(BuildContext context) {
    final sectionGap = context.responsivePadding(12);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: Avatar Info
          Container(
            width: context.responsiveValue(
              small: 100,
              medium: 140,
              large: 160,
              extraLarge: 180,
            ),
            padding: EdgeInsets.all(context.responsivePadding(24)),
            child: ProfileLeftColumn(guest: guest),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.divider.withValues(alpha: 0.5),
          ),
          // Right: Stats + Data
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Row
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsivePadding(16),
                    horizontal: context.responsivePadding(24),
                  ),
                  child: StatsStrip(isLandscape: isLandscape),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
                // Data Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(context.responsivePadding(24)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Forms
                        Expanded(flex: 3, child: FormFields()),
                        SizedBox(width: sectionGap),
                        // Metrics (Loyalty/Visits)
                        Expanded(flex: 4, child: MetricGrids()),
                        SizedBox(width: sectionGap),
                        // Empty States
                        Expanded(
                          flex: 3,
                          child: EmptyStatesRow(isLandscape: isLandscape),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
