import 'package:flutter/material.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController({Locale initialLocale = const Locale('en')})
    : _locale = initialLocale;
  Locale _locale;
  Locale get locale => _locale;
  void changeLocale(Locale locale) {
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
}
