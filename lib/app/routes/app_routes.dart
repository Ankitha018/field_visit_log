import 'package:flutter/material.dart';

import '../../core/localization/localization_controller.dart';
import '../../domain/entities/visit.dart';
import '../../presentation/screens/create_visit_screen.dart';
import '../../presentation/screens/language_screen.dart';
import '../../presentation/screens/update_visit_screen.dart';
import '../../presentation/screens/visit_details_screen.dart';
import '../../presentation/screens/visit_list_screen.dart';
import 'route_names.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    LocalizationController? localizationController,
  }) {
    switch (settings.name) {
      case RouteNames.visits:
        return MaterialPageRoute(builder: (_) => const VisitListScreen());

      case RouteNames.createVisit:
        return MaterialPageRoute(builder: (_) => const CreateVisitScreen());

      case RouteNames.updateVisit:
        final visit = settings.arguments as Visit;

        return MaterialPageRoute(
          builder: (_) => UpdateVisitScreen(visit: visit),
        );

      case RouteNames.visitDetails:
        final visit = settings.arguments as Visit;

        return MaterialPageRoute(
          builder: (_) => VisitDetailsScreen(visit: visit),
        );

      case RouteNames.language:
        return MaterialPageRoute(
          builder: (_) => LanguageScreen(controller: localizationController!),
        );

      default:
        return MaterialPageRoute(builder: (_) => const VisitListScreen());
    }
  }
}
