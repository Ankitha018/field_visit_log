import 'package:flutter/material.dart';

class VisitFilter extends StatelessWidget {
  const VisitFilter({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search visits',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
