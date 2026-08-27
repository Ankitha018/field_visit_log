import 'package:flutter/material.dart';

import '../../core/components/buttons/primary_button.dart';
import '../../core/components/inputs/app_date_field.dart';
import '../../core/components/inputs/app_text_field.dart';

class VisitForm extends StatefulWidget {
  const VisitForm({
    super.key,
    this.initialDate,
    this.initialLocation,
    this.initialNote,
    required this.onSubmit,
    this.buttonText = 'Save',
  });

  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialNote;
  final VoidCallback onSubmit;
  final String buttonText;

  @override
  State<VisitForm> createState() => _VisitFormState();
}

class _VisitFormState extends State<VisitForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _locationController;
  late final TextEditingController _noteController;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _locationController = TextEditingController(
      text: widget.initialLocation ?? '',
    );

    _noteController = TextEditingController(
      text: widget.initialNote ?? '',
    );

    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    _locationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppDateField(
            label: 'Date',
            value: _selectedDate,
            onChanged: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          const SizedBox(height: 16),

          AppTextField(
            controller: _locationController,
            label: 'Location',
          ),

          const SizedBox(height: 16),

          AppTextField(
            controller: _noteController,
            label: 'Note',
            maxLines: 4,
          ),

          const SizedBox(height: 24),

          PrimaryButton(
            label: widget.buttonText,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit();
              }
            },
          ),
        ],
      ),
    );
  }
}