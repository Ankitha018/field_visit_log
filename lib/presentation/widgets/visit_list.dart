import 'package:flutter/material.dart';
import '../../domain/entities/visit.dart';
import 'visit_card.dart';

class VisitList extends StatelessWidget {
  const VisitList({super.key, required this.visits, this.onVisitTap});
  final List<Visit> visits;
  final ValueChanged<Visit>? onVisitTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: visits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final visit = visits[index];
        return VisitCard(
          visit: visit,
          onTap: onVisitTap == null ? null : () => onVisitTap!(visit),
        );
      },
    );
  }
}
