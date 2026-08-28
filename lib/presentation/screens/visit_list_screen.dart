import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/feedback/empty_state.dart';
import '../../core/components/feedback/error_view.dart';
import '../../core/components/feedback/loading_view.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_list.dart';

class VisitListScreen extends StatefulWidget {
  const VisitListScreen({super.key});

  @override
  State<VisitListScreen> createState() => _VisitListScreenState();
}

class _VisitListScreenState extends State<VisitListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VisitBloc>().add(const LoadVisits());
      }
    });
  }

  Future<void> _openCreateVisit() async {
    await Navigator.pushNamed(context, RouteNames.createVisit);

    if (!mounted) {
      return;
    }

    context.read<VisitBloc>().add(const LoadVisits());
  }

  Future<void> _openVisitDetails(visit) async {
    await Navigator.pushNamed(
      context,
      RouteNames.visitDetails,
      arguments: visit,
    );

    if (!mounted) {
      return;
    }

    context.read<VisitBloc>().add(const LoadVisits());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Field Visits')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateVisit,
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
              onAction: _openCreateVisit,
            );
          }

          if (state is VisitError) {
            return ErrorView(message: state.message);
          }

          if (state is VisitLoaded) {
            return VisitList(
              visits: state.visits,
              onVisitTap: _openVisitDetails,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
