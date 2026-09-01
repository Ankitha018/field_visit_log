import '../../domain/entities/visit.dart';
import '../../domain/enums/visit_status.dart';

class VisitModel {
  const VisitModel({
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

  factory VisitModel.fromMap(Map<String, dynamic> map) {
    final stage = map['stage'] as String?;
    return VisitModel(
      id: map['id'] as String,
      siteName: map['site_name'] as String,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      notes: map['notes'] as String,
      status: stage == null ? VisitStatus.draft : VisitStatus.fromString(stage),
      createdAt: DateTime.parse(map['created_at'] as String),
      syncedAt: map['synced_at'] == null
          ? null
          : DateTime.parse(map['synced_at'] as String),
    );
  }

  Map<String, dynamic> toLocalVisitMap() {
    return {
      'id': id,
      'site_name': siteName,
      'date': date.toIso8601String(),
      'location': location,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toVisitLogMap() {
    return {
      'id': id,
      'site_name': siteName,
      'date': date.toIso8601String(),
      'location': location,
      'notes': notes,
      'stage': status.value,
      'created_at': createdAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
    };
  }

  Visit toEntity() {
    return Visit(
      id: id,
      siteName: siteName,
      date: date,
      location: location,
      notes: notes,
      status: status,
      createdAt: createdAt,
      syncedAt: syncedAt,
    );
  }

  factory VisitModel.fromEntity(Visit visit) {
    return VisitModel(
      id: visit.id,
      siteName: visit.siteName,
      date: visit.date,
      location: visit.location,
      notes: visit.notes,
      status: visit.status,
      createdAt: visit.createdAt,
      syncedAt: visit.syncedAt,
    );
  }
}
