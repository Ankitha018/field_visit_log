import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/routes/route_names.dart';
import '../../core/components/chips/status_chip.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/snackbar_helper.dart';
import '../../domain/entities/visit.dart';
import '../../domain/enums/visit_status.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';

class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({super.key, required this.visit});
  final Visit visit;
  @override
  State<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  late Visit _visit;
  @override
  void initState() {
    super.initState();
    _visit = widget.visit;
  }

  StatusChipType _getStatusType(VisitStatus status) {
    switch (status) {
      case VisitStatus.draft:
        return StatusChipType.neutral;
      case VisitStatus.synced:
        return StatusChipType.success;
      case VisitStatus.failed:
        return StatusChipType.error;
    }
  }

  String _getStatusLabel(BuildContext context, VisitStatus status) {
    final l10n = AppLocalizations.of(context);
    switch (status) {
      case VisitStatus.draft:
        return l10n.draft;
      case VisitStatus.synced:
        return l10n.synced;
      case VisitStatus.failed:
        return l10n.failed;
    }
  }

  Future<void> _openEditScreen() async {
    final updatedVisit = await Navigator.pushNamed(
      context,
      RouteNames.updateVisit,
      arguments: _visit,
    );
    if (!mounted) {
      return;
    }
    if (updatedVisit is Visit) {
      setState(() {
        _visit = updatedVisit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.visitDetails),
      ),
      body: BlocConsumer<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitSynced) {
            setState(() {
              _visit = state.visit;
            });
            SnackbarHelper.showSuccess(context, l10n.visitSyncedSuccessfully);
          }
          if (state is VisitDraft) {
            setState(() {
              _visit = state.visit;
            });
            SnackbarHelper.showSuccess(context, l10n.visitSavedAsDraft);
          }
          if (state is VisitFailed) {
            setState(() {
              _visit = state.visit;
            });
            SnackbarHelper.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final saving = state is VisitSaving;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLg,
                vertical: AppSpacing.paddingMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _visit.siteName,
                            style: AppTextStyles.headline.copyWith(
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.gapMd),
                          StatusChip(
                            label: _getStatusLabel(context, _visit.status),
                            type: _getStatusType(_visit.status),
                          ),
                          const SizedBox(height: AppSpacing.gapXl),
                          const Divider(
                            color: AppColors.line,
                            thickness: AppDimensions.dividerThickness,
                          ),
                          const SizedBox(height: AppSpacing.gapXl),
                          _DetailRow(
                            label: l10n.date.toUpperCase(),
                            value: l10n.getFieldVisitDate(_visit.date),
                          ),
                          const SizedBox(height: AppSpacing.gapLg),

                          _DetailRow(
                            label: l10n.location.toUpperCase(),
                            value: _visit.location,
                          ),
                          const SizedBox(height: AppSpacing.gapLg),
                          _DetailRow(
                            label: l10n.loggedBy.toUpperCase(),
                            value: l10n.fieldVisitLog,
                          ),
                          const SizedBox(height: AppSpacing.gapXl),
                          const Divider(
                            color: AppColors.line,
                            thickness: AppDimensions.dividerThickness,
                          ),
                          const SizedBox(height: AppSpacing.gapXl),
                          Text(l10n.notes, style: AppTextStyles.label),
                          const SizedBox(height: AppSpacing.gapSm),
                          Text(
                            _visit.notes.isEmpty ? '-' : _visit.notes,
                            style: AppTextStyles.body.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.gapMd),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: AppDimensions.controlHeight,
                          child: OutlinedButton(
                            onPressed: _openEditScreen,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.foreground,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(l10n.edit),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.gapMd),
                      Expanded(
                        child: SizedBox(
                          height: AppDimensions.controlHeight,
                          child: ElevatedButton(
                            onPressed: saving
                                ? null
                                : () {
                                    context.read<VisitBloc>().add(
                                      SyncVisitEvent(visit: _visit),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(saving ? l10n.saving : l10n.save),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: AppTextStyles.body.copyWith(fontSize: 16)),
        ),
      ],
    );
  }
}
