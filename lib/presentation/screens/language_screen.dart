import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/localization_controller.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, required this.controller});

  final LocalizationController controller;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.controller.locale;
  }

  void _saveLanguage() {
    widget.controller.changeLocale(_selectedLocale);
    Navigator.pop(context);
  }

  void _onLanguageChanged(Locale? locale) {
    if (locale == null) {
      return;
    }

    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.selectLanguage, style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: RadioGroup<Locale>(
                groupValue: _selectedLocale,
                onChanged: _onLanguageChanged,
                child: Column(
                  children: [
                    RadioListTile<Locale>(
                      value: const Locale('en'),
                      title: Text(l10n.english),
                    ),
                    RadioListTile<Locale>(
                      value: const Locale('de'),
                      title: Text(l10n.german),
                    ),
                    RadioListTile<Locale>(
                      value: const Locale('hi'),
                      title: Text(l10n.hindi),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveLanguage,
                child: Text(l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
