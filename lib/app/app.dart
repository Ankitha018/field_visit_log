import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../presentation/bloc/network/network_event.dart';
import '../presentation/bloc/visit/visit_event.dart';
import 'di/injection.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

class FieldVisitApp extends StatelessWidget {
  const FieldVisitApp({super.key});

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
        initialRoute: RouteNames.visits,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
