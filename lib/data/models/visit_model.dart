import '../../domain/entities/visit.dart';

class VisitModel {
  const VisitModel({
    required this.id,
    required this.date,
    required this.location,
    required this.note,
    required this.status,
    required this.createdAt,
    this.syncedAt,
  });

  final String id;
  final DateTime date;
  final String location;
  final String note;
  final VisitStatus status;
  final DateTime createdAt;
  final DateTime? syncedAt;

  Map<String, dynamic> toLocalMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'location': location,
      'note': note,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toLogMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'location': location,
      'note': note,
      'stage': status.value,
      'created_at': createdAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
    };
  }

  factory VisitModel.fromLocalMap(
      Map<String, dynamic> map,
      ) {
    return VisitModel(
      id: map['id'] as String,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      note: map['note'] as String,
      status: VisitStatus.draft,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }

  factory VisitModel.fromLogMap(
      Map<String, dynamic> map,
      ) {
    return VisitModel(
      id: map['id'] as String,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      note: map['note'] as String,
      status: VisitStatusExtension.fromValue(
        map['stage'] as String,
      ),
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
      syncedAt: map['synced_at'] == null
          ? null
          : DateTime.parse(
        map['synced_at'] as String,
      ),
    );
  }
}