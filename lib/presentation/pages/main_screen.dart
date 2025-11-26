import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/di/injection_container.dart';
import '../bloc/panel_bloc/panel_bloc.dart';
import '../bloc/panel_bloc/panel_event.dart';
import '../bloc/panel_bloc/panel_state.dart';
import '../bloc/guest_list_bloc/guest_list_bloc.dart';
import '../bloc/guest_list_bloc/guest_list_event.dart';
import '../widgets/guest_list_panel.dart';
import '../widgets/detail_panel.dart';

/// Main screen with two-panel layout - Pure UI Widget
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PanelBloc>(create: (context) => sl<PanelBloc>()),
        BlocProvider<GuestListBloc>(
          create: (context) =>
              sl<GuestListBloc>()..add(const LoadGuestListEvent()),
        ),
      ],
      child: const MainScreenView(),
    );
  }
}

/// Main screen view that responds to BLoC state changes
class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PanelBloc, PanelState>(
        builder: (context, panelState) {
          if (panelState is PanelInitial) {
            final shouldExpand = PanelBloc.shouldExpandByDefault(
              MediaQuery.of(context).size.width,
            );

            // Send initialization event from UI layer
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.read<PanelBloc>().add(
                  InitializePanelEvent(shouldExpand: shouldExpand),
                );
              }
            });

            // Return loading state while initializing
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return Row(
            children: [
              // Left Panel (Guest List)
              _buildLeftPanel(context, panelState),

              // Right Panel (Detail View)
              _buildRightPanel(context, panelState),
            ],
          );
        },
      ),
    );
  }

  /// Build the left panel with guest list
  Widget _buildLeftPanel(BuildContext context, PanelState panelState) {
    final panelWidth = context.leftPanelWidth;
    final currentWidth = panelState.getCurrentWidth(panelWidth);

    // Minimum width to show content (prevents overflow during animation)
    const minContentWidth = 150.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: currentWidth,
      constraints: BoxConstraints(minWidth: 0, maxWidth: currentWidth),
      child: currentWidth > minContentWidth
          ? ClipRect(
              child: SizedBox(
                width: currentWidth,
                child: Container(
                  color: AppColors.darkSidebar,
                  child: const GuestListPanel(),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  /// Build the right panel with detail view
  Widget _buildRightPanel(BuildContext context, PanelState panelState) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Collapse panel when tapping on right side
          if (panelState.isExpanded) {
            context.read<PanelBloc>().add(const CollapsePanelEvent());
          }
        },
        child: Container(
          color: AppColors.lightPanel,
          child: Column(
            children: [
              // App Bar
              _buildAppBar(context, panelState),

              // Detail Content
              const Expanded(child: DetailPanel()),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the app bar with navigation
  Widget _buildAppBar(BuildContext context, PanelState panelState) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // Back/Menu button
          IconButton(
            icon: Icon(
              panelState.isExpanded ? Icons.arrow_back : Icons.menu,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              if (panelState.isExpanded) {
                context.read<PanelBloc>().add(const CollapsePanelEvent());
              } else {
                context.read<PanelBloc>().add(const ExpandPanelEvent());
              }
            },
            tooltip: panelState.isExpanded
                ? 'Hide guest list'
                : 'Show guest list',
          ),

          // Title
          Expanded(
            child: Text(
              AppConstants.appName,
              style: GoogleFonts.montserrat(
                fontSize: context.responsiveFontSize(18),
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Additional actions can be added here
        ],
      ),
    );
  }
}
