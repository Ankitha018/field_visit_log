import 'package:flutter/material.dart';

import '../../core/components/buttons/primary_button.dart';
import '../../core/components/inputs/app_date_field.dart';
import '../../core/components/inputs/app_text_field.dart';
import '../../core/theme/app_spacing.dart';

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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          children: [
            AppTextField(controller: _siteNameController, label: 'Site name'),

            const SizedBox(height: AppSpacing.paddingMd),

            AppDateField(
              label: 'Date',
              value: _selectedDate,
              onChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),

            const SizedBox(height: AppSpacing.paddingMd),
            AppTextField(controller: _locationController, label: 'Location'),
            const SizedBox(height: AppSpacing.paddingMd),
            AppTextField(
              controller: _notesController,
              label: 'Notes',
              maxLines: 4,
            ),
            const SizedBox(height: AppSpacing.paddingLg),
            PrimaryButton(label: widget.buttonText, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
