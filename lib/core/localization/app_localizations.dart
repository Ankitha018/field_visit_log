import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('de'), Locale('hi')];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );

    assert(localizations != null);

    return localizations!;
  }

  String get languageName {
    switch (locale.languageCode) {
      case 'de':
        return 'Deutsch';
      case 'hi':
        return 'हिन्दी';
      case 'en':
      default:
        return 'English';
    }
  }

  String get fieldVisits {
    switch (locale.languageCode) {
      case 'de':
        return 'Feldbesuche';
      case 'hi':
        return 'फील्ड विज़िट';
      case 'en':
      default:
        return 'Field Visits';
    }
  }

  String get createVisit {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuch erstellen';
      case 'hi':
        return 'विज़िट बनाएं';
      case 'en':
      default:
        return 'Create Visit';
    }
  }

  String get updateVisit {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuch aktualisieren';
      case 'hi':
        return 'विज़िट अपडेट करें';
      case 'en':
      default:
        return 'Update Visit';
    }
  }

  String get visitDetails {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuchsdetails';
      case 'hi':
        return 'विज़िट विवरण';
      case 'en':
      default:
        return 'Visit Details';
    }
  }

  String get save {
    switch (locale.languageCode) {
      case 'de':
        return 'Speichern';
      case 'hi':
        return 'सहेजें';
      case 'en':
      default:
        return 'Save';
    }
  }

  String get update {
    switch (locale.languageCode) {
      case 'de':
        return 'Aktualisieren';
      case 'hi':
        return 'अपडेट करें';
      case 'en':
      default:
        return 'Update';
    }
  }

  String get siteName {
    switch (locale.languageCode) {
      case 'de':
        return 'Standortname';
      case 'hi':
        return 'साइट का नाम';
      case 'en':
      default:
        return 'Site name';
    }
  }

  String get date {
    switch (locale.languageCode) {
      case 'de':
        return 'Datum';
      case 'hi':
        return 'तारीख';
      case 'en':
      default:
        return 'Date';
    }
  }

  String get location {
    switch (locale.languageCode) {
      case 'de':
        return 'Ort';
      case 'hi':
        return 'स्थान';
      case 'en':
      default:
        return 'Location';
    }
  }

  String get notes {
    switch (locale.languageCode) {
      case 'de':
        return 'Notizen';
      case 'hi':
        return 'नोट्स';
      case 'en':
      default:
        return 'Notes';
    }
  }

  String get noVisitsYet {
    switch (locale.languageCode) {
      case 'de':
        return 'Noch keine Besuche';
      case 'hi':
        return 'अभी कोई विज़िट नहीं';
      case 'en':
      default:
        return 'No visits yet';
    }
  }

  String get createFirstVisit {
    switch (locale.languageCode) {
      case 'de':
        return 'Erstellen Sie Ihren ersten Feldbesuch.';
      case 'hi':
        return 'अपनी पहली फील्ड विज़िट बनाएं।';
      case 'en':
      default:
        return 'Create your first field visit.';
    }
  }

  String get offlineMessage {
    switch (locale.languageCode) {
      case 'de':
        return 'Sie sind offline. Gespeicherte Besuche werden angezeigt.';
      case 'hi':
        return 'आप ऑफ़लाइन हैं। सहेजी गई विज़िट दिखाई जा रही हैं।';
      case 'en':
      default:
        return 'You are offline. Showing saved visits.';
    }
  }

  String get draft {
    switch (locale.languageCode) {
      case 'de':
        return 'Entwurf';
      case 'hi':
        return 'ड्राफ्ट';
      case 'en':
      default:
        return 'Draft';
    }
  }

  String get synced {
    switch (locale.languageCode) {
      case 'de':
        return 'Synchronisiert';
      case 'hi':
        return 'सिंक किया गया';
      case 'en':
      default:
        return 'Synced';
    }
  }

  String get failed {
    switch (locale.languageCode) {
      case 'de':
        return 'Fehlgeschlagen';
      case 'hi':
        return 'विफल';
      case 'en':
      default:
        return 'Failed';
    }
  }

  String get syncFailed {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuch konnte nicht synchronisiert werden.';
      case 'hi':
        return 'विज़िट सिंक नहीं हो सकी।';
      case 'en':
      default:
        return 'Visit sync failed.';
    }
  }

  String get visitSyncedSuccessfully {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuch erfolgreich synchronisiert.';
      case 'hi':
        return 'विज़िट सफलतापूर्वक सिंक हो गई।';
      case 'en':
      default:
        return 'Visit synced successfully.';
    }
  }

  String get visitSavedAsDraft {
    switch (locale.languageCode) {
      case 'de':
        return 'Besuch als Entwurf gespeichert.';
      case 'hi':
        return 'विज़िट ड्राफ्ट के रूप में सहेजी गई।';
      case 'en':
      default:
        return 'Visit saved as draft.';
    }
  }

  String get language {
    switch (locale.languageCode) {
      case 'de':
        return 'Sprache';
      case 'hi':
        return 'भाषा';
      case 'en':
      default:
        return 'Language';
    }
  }

  String get selectLanguage {
    switch (locale.languageCode) {
      case 'de':
        return 'Sprache auswählen';
      case 'hi':
        return 'भाषा चुनें';
      case 'en':
      default:
        return 'Select Language';
    }
  }

  String get english {
    return 'English';
  }

  String get german {
    return 'Deutsch';
  }

  String get hindi {
    return 'हिन्दी';
  }

  // -----------------------------
  // Visit details / update screen
  // -----------------------------

  String get edit {
    switch (locale.languageCode) {
      case 'de':
        return 'Bearbeiten';
      case 'hi':
        return 'संपादित करें';
      case 'en':
      default:
        return 'Edit';
    }
  }

  String get saveChanges {
    switch (locale.languageCode) {
      case 'de':
        return 'Änderungen speichern';
      case 'hi':
        return 'परिवर्तन सहेजें';
      case 'en':
      default:
        return 'Save changes';
    }
  }

  String get saving {
    switch (locale.languageCode) {
      case 'de':
        return 'Speichern...';
      case 'hi':
        return 'सहेजा जा रहा है...';
      case 'en':
      default:
        return 'Saving...';
    }
  }

  String get loggedBy {
    switch (locale.languageCode) {
      case 'de':
        return 'Erstellt von';
      case 'hi':
        return 'द्वारा दर्ज';
      case 'en':
      default:
        return 'Logged by';
    }
  }

  String get fieldVisitLog {
    switch (locale.languageCode) {
      case 'de':
        return 'Feldbesuchsprotokoll';
      case 'hi':
        return 'फील्ड विज़िट लॉग';
      case 'en':
      default:
        return 'Field Visit Log';
    }
  }

  String getFieldVisitDate(DateTime date) {
    return DateFormat.yMMMd(locale.toLanguageTag()).format(date);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}
