import 'package:equatable/equatable.dart';

import '../enums/visit_status.dart';

class Visit extends Equatable {
  const Visit({
    required this.id,
    required this.siteName,
    required this.date,
    required this.location,
    required this.notes,
    required this.status,
    required this.createdAt,
    this.syncedAt,
  });

  final String id;
  final String siteName;
  final DateTime date;
  final String location;
  final String notes;
  final VisitStatus status;
  final DateTime createdAt;
  final DateTime? syncedAt;

  Visit copyWith({
    String? id,
    String? siteName,
    DateTime? date,
    String? location,
    String? notes,
    VisitStatus? status,
    DateTime? createdAt,
    DateTime? syncedAt,
  }) {
    return Visit(
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
      date: date ?? this.date,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    siteName,
    date,
    location,
    notes,
    status,
    createdAt,
    syncedAt,
  ];
}
