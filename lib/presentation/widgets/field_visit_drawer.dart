import 'package:flutter/material.dart';
import '../../app/routes/route_names.dart';
import '../../core/localization/app_localizations.dart';

class FieldVisitDrawer extends StatelessWidget {
  const FieldVisitDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String drawerTitle;

    switch (l10n.locale.languageCode) {
      case 'de':
        drawerTitle = 'Feldbesuchsprotokoll';
        break;
      case 'hi':
        drawerTitle = 'फील्ड विज़िट लॉग';
        break;
      case 'en':
      default:
        drawerTitle = 'Field Visit Log';
    }

    return Drawer(
      width: 280,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 48, 24, 28),
              child: Text(
                drawerTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const Divider(height: 1, thickness: 1),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 10,
              ),
              leading: const Icon(Icons.list_alt_outlined, size: 30),
              title: Text(
                l10n.fieldVisits,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 10,
              ),
              leading: const Icon(Icons.add_circle_outline, size: 30),
              title: Text(
                l10n.createVisit,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.createVisit);
              },
            ),
            const Divider(height: 1, thickness: 1),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 10,
              ),
              leading: const Icon(Icons.language, size: 30),
              title: Text(
                l10n.language,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                l10n.languageName,
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.language);
              },
            ),
          ],
        ),
      ),
    );
  }
}
