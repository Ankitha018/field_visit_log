import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/feedback/empty_state.dart';
import '../../core/components/feedback/error_view.dart';
import '../../core/components/feedback/loading_view.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_list.dart';

class VisitListScreen extends StatelessWidget {
  const VisitListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Visits'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteNames.createVisit,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          if (state is VisitLoading) {
            return const LoadingView();
          }

          if (state is VisitEmpty) {
            return EmptyState(
              title: 'No visits yet',
              icon: Icons.assignment_outlined,
              message: 'Create your first field visit.',
              onAction: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.createVisit,
                );
              },
            );
          }

          if (state is VisitError) {
            return ErrorView(
              message: state.message,
            );
          }

          if (state is VisitLoaded) {
            return VisitList(
              visits: state.visits,
              onVisitTap: (visit) {
                Navigator.pushNamed(
                  context,
                  RouteNames.visitDetails,
                  arguments: visit,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}