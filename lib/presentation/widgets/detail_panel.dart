/// Detail panel widget for displaying selected guest information
/// This widget shows detailed guest information in the right panel
/// matching the screenshot design exactly.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/di/injection_container.dart';
import '../../core/utils/design_utils.dart';
import '../bloc/guest_list_bloc/guest_list_bloc.dart';
import '../bloc/guest_list_bloc/guest_list_state.dart';
import '../bloc/tab_bloc/tab_bloc.dart';
import '../bloc/tab_bloc/tab_event.dart';
import '../bloc/tab_bloc/tab_state.dart';
import 'common/responsive_padding.dart';
import 'common/responsive_text.dart';

/// Panel widget for displaying guest details - matches screenshot exactly
class DetailPanel extends StatelessWidget {
  const DetailPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (context) => sl<TabBloc>()..add(const InitializeTabsEvent()),
      child: BlocBuilder<GuestListBloc, GuestListState>(
        builder: (context, state) {
          if (state.isLoaded) {
            final loadedState = state as GuestListLoaded;

            if (loadedState.hasSelectedGuest) {
              return _buildGuestDetail(context, loadedState);
            }
          }

          return _buildWelcomeScreen(context);
        },
      ),
    );
  }

  /// Build guest detail view matching screenshot layout
  Widget _buildGuestDetail(BuildContext context, GuestListLoaded state) {
    final guest = state.selectedGuest!;

    return Column(
      children: [
        // Header section with guest basic info and icon
        Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Guest Book icon at the top
              Icon(Icons.menu_book, size: 48, color: AppColors.textSecondary),

              const SizedBox(height: 16),

              // Guest Book title
              ResponsiveText(
                'Guest Book',
                style: ResponsiveTextStyle.displayMedium,
                color: AppColors.textPrimary,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Description
              ResponsiveText(
                AppConstants.guestBookDescription,
                style: ResponsiveTextStyle.bodyMedium,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ],
          ),
        ),

        // Tab Bar
        _buildTabBar(context),

        // Tab Content
        Expanded(
          child: BlocBuilder<TabBloc, TabState>(
            builder: (context, tabState) {
              final selectedIndex = tabState.selectedTabIndex ?? 0;

              return IndexedStack(
                index: selectedIndex,
                children: [
                  _buildProfileTab(context, guest),
                  _buildTabPlaceholder('Reservation', Icons.calendar_today),
                  _buildTabPlaceholder('Payment', Icons.payment),
                  _buildTabPlaceholder('Feedback', Icons.feedback),
                  _buildTabPlaceholder('Order History', Icons.history),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// Build welcome screen when no guest is selected
  Widget _buildWelcomeScreen(BuildContext context) {
    return ResponsivePadding.large(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Guest book icon
          Icon(
            Icons.menu_book,
            size: 120,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),

          const SizedBox(height: 32),

          // Title
          ResponsiveText(
            AppConstants.appName,
            style: ResponsiveTextStyle.displayMedium,
            color: AppColors.textPrimary,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Description
          ResponsiveText(
            AppConstants.guestBookDescription,
            style: ResponsiveTextStyle.bodyLarge,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
            maxLines: 4,
          ),

          const SizedBox(height: 32),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ResponsiveText(
              'Select a guest from the list to view their details',
              style: ResponsiveTextStyle.bodyMedium,
              color: AppColors.primary,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Build tab bar matching screenshot style
  Widget _buildTabBar(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        final selectedIndex = state.selectedTabIndex ?? 0;

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              bottom: BorderSide(color: AppColors.divider, width: 1.0),
            ),
          ),
          child: Row(
            children: List.generate(
              AppConstants.navigationTabs.length,
              (index) => _buildTabButton(
                context,
                AppConstants.navigationTabs[index],
                index,
                selectedIndex == index,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build individual tab button
  Widget _buildTabButton(
    BuildContext context,
    String title,
    int index,
    bool isSelected,
  ) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<TabBloc>().add(SelectTabEvent(index));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: isSelected
                  ? const Border(
                      bottom: BorderSide(color: AppColors.primary, width: 2),
                    )
                  : null,
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.transparent,
            ),
            child: ResponsiveText(
              title,
              style: ResponsiveTextStyle.bodyMedium,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              textAlign: TextAlign.center,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  /// Build profile tab content matching screenshot layout
  Widget _buildProfileTab(BuildContext context, guest) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Guest profile header
          _buildGuestProfileHeader(context, guest),

          const SizedBox(height: 32),

          // Statistics grid
          _buildStatisticsSection(context, guest),

          const SizedBox(height: 32),

          // Loyalty and Visits section
          _buildLoyaltyVisitsSection(context, guest),

          const SizedBox(height: 32),

          // Upcoming visits section
          _buildUpcomingVisitsSection(context, guest),

          const SizedBox(height: 32),

          // Notes and sections
          _buildNotesSection(context, guest),
        ],
      ),
    );
  }

  /// Build guest profile header with avatar and basic info
  Widget _buildGuestProfileHeader(BuildContext context, guest) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignUtils.getAvatarColor(guest.name),
          ),
          child: Center(
            child: ResponsiveText(
              guest.initials,
              style: ResponsiveTextStyle.displaySmall,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 24),

        // Guest info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                guest.name,
                style: ResponsiveTextStyle.displayMedium,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 4),

              ResponsiveText(
                guest.email,
                style: ResponsiveTextStyle.bodyMedium,
                color: AppColors.textSecondary,
              ),

              if (guest.phone.isNotEmpty) ...[
                const SizedBox(height: 4),
                ResponsiveText(
                  DesignUtils.formatPhoneNumber(guest.phone),
                  style: ResponsiveTextStyle.bodyMedium,
                  color: AppColors.textSecondary,
                ),
              ],
            ],
          ),
        ),

        // Add Tags button
        OutlinedButton(
          onPressed: () {},
          child: const ResponsiveText('Add Tags'),
        ),
      ],
    );
  }

  /// Build statistics section matching screenshot layout
  Widget _buildStatisticsSection(BuildContext context, guest) {
    return Row(
      children: [
        // Last Visit, Average Spend, etc.
        Expanded(
          child: _buildStatCard(
            context,
            '\$${guest.averageSpend.toStringAsFixed(2)}',
            'Last Visit',
            'Average Spend',
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _buildStatCard(
            context,
            '\$${guest.lifetimeSpend.toStringAsFixed(2)}',
            'Lifetime Spend',
            'Total Orders',
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _buildStatCard(
            context,
            '${guest.totalOrders}',
            'Total Orders',
            'Average Tip',
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _buildStatCard(
            context,
            '\$${guest.averageTip.toStringAsFixed(2)}',
            'Average Tip',
            '',
          ),
        ),
      ],
    );
  }

  /// Build individual statistics card
  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label1,
    String label2,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            value,
            style: ResponsiveTextStyle.headlineMedium,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 4),

          ResponsiveText(
            label1,
            style: ResponsiveTextStyle.bodySmall,
            color: AppColors.textSecondary,
          ),

          if (label2.isNotEmpty) ...[
            ResponsiveText(
              label2,
              style: ResponsiveTextStyle.bodySmall,
              color: AppColors.textSecondary,
            ),
          ],
        ],
      ),
    );
  }

  /// Build loyalty and visits section
  Widget _buildLoyaltyVisitsSection(BuildContext context, guest) {
    return Row(
      children: [
        // Loyalty section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                'LOYALTY',
                style: ResponsiveTextStyle.labelMedium,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.loyaltyEarned}',
                      'Earned',
                    ),
                  ),
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.loyaltyRedeemed}',
                      'Redeemed',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '\$${guest.loyaltyAvailable.toStringAsFixed(2)}',
                      'Available',
                    ),
                  ),
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.loyaltyAmount}',
                      'Amount',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 32),

        // Visits section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                'VISITS',
                style: ResponsiveTextStyle.labelMedium,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.totalVisits}',
                      'Total Visits',
                    ),
                  ),
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.upcomingVisits}',
                      'Upcoming',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.cancelledVisits}',
                      'Cancelled',
                    ),
                  ),
                  Expanded(
                    child: _buildLoyaltyMetric(
                      context,
                      '${guest.noShows}',
                      'No Shows',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build individual loyalty/visit metric
  Widget _buildLoyaltyMetric(BuildContext context, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          value,
          style: ResponsiveTextStyle.headlineSmall,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),

        ResponsiveText(
          label,
          style: ResponsiveTextStyle.bodySmall,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  /// Build upcoming visits section
  Widget _buildUpcomingVisitsSection(BuildContext context, guest) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ResponsiveText(
              'UPCOMING VISITS',
              style: ResponsiveTextStyle.labelMedium,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),

            const Spacer(),

            OutlinedButton(
              onPressed: () {},
              child: const ResponsiveText('Book A Visit'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Icon(Icons.event_note, color: AppColors.textTertiary, size: 24),

              const SizedBox(width: 16),

              ResponsiveText(
                'No Upcoming Visits',
                style: ResponsiveTextStyle.bodyMedium,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build notes section
  Widget _buildNotesSection(BuildContext context, guest) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'NOTES',
          style: ResponsiveTextStyle.labelMedium,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),

        const SizedBox(height: 16),

        ...AppConstants.notesSections
            .map((section) => _buildNoteSection(context, section))
            .toList(),
      ],
    );
  }

  /// Build individual note section
  Widget _buildNoteSection(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(_getNoteIcon(title), color: AppColors.textTertiary, size: 20),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveText(
                  title,
                  style: ResponsiveTextStyle.bodyMedium,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),

                ResponsiveText(
                  'Add notes...',
                  style: ResponsiveTextStyle.bodySmall,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get appropriate icon for note section
  IconData _getNoteIcon(String title) {
    switch (title) {
      case 'General':
        return Icons.note;
      case 'Special Relation':
        return Icons.favorite;
      case 'Seating Preferences':
        return Icons.event_seat;
      case 'Special Note*':
        return Icons.star;
      case 'Allergies':
        return Icons.warning;
      default:
        return Icons.note;
    }
  }

  /// Build tab placeholder for non-profile tabs
  Widget _buildTabPlaceholder(String title, IconData icon) {
    return ResponsivePadding.large(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: AppColors.textTertiary),

                const SizedBox(height: 16),

                ResponsiveText(
                  '$title coming soon',
                  style: ResponsiveTextStyle.headlineSmall,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
