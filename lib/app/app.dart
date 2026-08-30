import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/localization/app_localizations.dart';
import '../core/localization/localization_controller.dart';
import '../core/theme/app_theme.dart';
import '../presentation/bloc/network/network_event.dart';
import '../presentation/bloc/visit/visit_event.dart';
import 'di/injection.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

class FieldVisitApp extends StatefulWidget {
  const FieldVisitApp({super.key});

  @override
  State<FieldVisitApp> createState() => _FieldVisitAppState();
}

class _FieldVisitAppState extends State<FieldVisitApp> {
  late final LocalizationController _localizationController;

  @override
  void initState() {
    super.initState();

    _localizationController = LocalizationController()
      ..addListener(_onLocaleChanged);
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _localizationController
      ..removeListener(_onLocaleChanged)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              Injection.createNetworkBloc()..add(const NetworkStarted()),
        ),
        BlocProvider(
          create: (_) => Injection.createVisitBloc()..add(const LoadVisits()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Visit',
        theme: AppTheme.lightTheme,
        locale: _localizationController.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: RouteNames.visits,
        onGenerateRoute: (settings) {
          return AppRoutes.generateRoute(
            settings,
            localizationController: _localizationController,
          );
        },
      ),
    );
  }
}
