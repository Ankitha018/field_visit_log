import 'package:flutter/material.dart';

import '../../core/components/buttons/primary_button.dart';
import '../../core/components/inputs/app_date_field.dart';
import '../../core/components/inputs/app_text_field.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class VisitForm extends StatefulWidget {
  const VisitForm({
    super.key,
    this.initialSiteName,
    this.initialDate,
    this.initialLocation,
    this.initialNotes,
    required this.onSubmit,
    this.buttonText = 'Save',
  });

  final String? initialSiteName;
  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialNotes;

  final void Function({
    required String siteName,
    required DateTime date,
    required String location,
    required String notes,
  })
  onSubmit;

  final String buttonText;

  @override
  State<VisitForm> createState() => _VisitFormState();
}

class _VisitFormState extends State<VisitForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _siteNameController;
  late final TextEditingController _locationController;
  late final TextEditingController _notesController;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _siteNameController = TextEditingController(
      text: widget.initialSiteName ?? '',
    );

    _locationController = TextEditingController(
      text: widget.initialLocation ?? '',
    );

    _notesController = TextEditingController(text: widget.initialNotes ?? '');

    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    _siteNameController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final date = _selectedDate;

    if (date == null) {
      return;
    }

    widget.onSubmit(
      siteName: _siteNameController.text.trim(),
      date: date,
      location: _locationController.text.trim(),
      notes: _notesController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(l10n.siteName),

          const SizedBox(height: AppSpacing.gapSm),

          AppTextField(controller: _siteNameController, label: l10n.siteName),

          const SizedBox(height: AppSpacing.gapLg),

          _buildLabel(l10n.date),

          const SizedBox(height: AppSpacing.gapSm),

          AppDateField(
            label: l10n.date,
            value: _selectedDate,
            onChanged: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          const SizedBox(height: AppSpacing.gapLg),

          _buildLabel(l10n.location),

          const SizedBox(height: AppSpacing.gapSm),

          AppTextField(controller: _locationController, label: l10n.location),

          const SizedBox(height: AppSpacing.gapLg),

          _buildLabel(l10n.notes),

          const SizedBox(height: AppSpacing.gapSm),

          AppTextField(
            controller: _notesController,
            label: l10n.notes,
            maxLines: 5,
          ),

          const SizedBox(height: AppSpacing.gapXl),

          SizedBox(
            width: double.infinity,
            height: AppDimensions.controlHeight,
            child: PrimaryButton(label: widget.buttonText, onPressed: _submit),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.foreground,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
