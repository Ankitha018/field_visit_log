import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/routes/route_names.dart';
import '../../core/components/feedback/empty_state.dart';
import '../../core/components/feedback/error_view.dart';
import '../../core/components/feedback/loading_view.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../bloc/network/network_bloc.dart';
import '../bloc/network/network_state.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/field_visit_drawer.dart';
import '../widgets/visit_list.dart';

class VisitListScreen extends StatefulWidget {
  const VisitListScreen({super.key});
  @override
  State<VisitListScreen> createState() => _VisitListScreenState();
}

class _VisitListScreenState extends State<VisitListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VisitBloc>().add(const LoadVisits());
      }
    });
  }

  Future<void> _openCreateVisit() async {
    await Navigator.pushNamed(context, RouteNames.createVisit);
    if (!mounted) {
      return;
    }
    context.read<VisitBloc>().add(const LoadVisits());
  }

  Future<void> _openVisitDetails(visit) async {
    await Navigator.pushNamed(
      context,
      RouteNames.visitDetails,
      arguments: visit,
    );
    if (!mounted) {
      return;
    }
    context.read<VisitBloc>().add(const LoadVisits());
  }

  Widget _buildOfflineBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        border: Border(
          bottom: BorderSide(color: AppColors.warning.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cloud_off_outlined,
            size: AppDimensions.iconSize,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.gapSm),
          Expanded(
            child: Text(
              AppLocalizations.of(context).offlineMessage,
              style: AppTextStyles.bodySecondary.copyWith(
                color: AppColors.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitContent(VisitState state) {
    if (state is VisitLoading) {
      return const LoadingView();
    }
    if (state is VisitEmpty) {
      return EmptyState(
        title: AppLocalizations.of(context).noVisitsYet,
        icon: Icons.assignment_outlined,
        message: AppLocalizations.of(context).createFirstVisit,
        onAction: _openCreateVisit,
      );
    }
    if (state is VisitError) {
      return ErrorView(message: state.message);
    }
    if (state is VisitLoaded) {
      return VisitList(visits: state.visits, onVisitTap: _openVisitDetails);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      drawer: const FieldVisitDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Open menu',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(l10n.fieldVisits),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateVisit,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, networkState) {
              if (networkState is NetworkOffline) {
                return _buildOfflineBanner();
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                return _buildVisitContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }
}
