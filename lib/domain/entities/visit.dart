enum VisitStatus {
  draft,
  synced,
  failed,
}

extension VisitStatusExtension on VisitStatus {
  String get value {
    switch (this) {
      case VisitStatus.draft:
        return 'draft';
      case VisitStatus.synced:
        return 'synced';
      case VisitStatus.failed:
        return 'failed';
    }
  }

  static VisitStatus fromValue(String value) {
    switch (value) {
      case 'synced':
        return VisitStatus.synced;
      case 'failed':
        return VisitStatus.failed;
      case 'draft':
      default:
        return VisitStatus.draft;
    }
  }
}

class Visit {
  const Visit({
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

  Visit copyWith({
    String? id,
    DateTime? date,
    String? location,
    String? note,
    VisitStatus? status,
    DateTime? createdAt,
    DateTime? syncedAt,
  }) {
    return Visit(
      id: id ?? this.id,
      date: date ?? this.date,
      location: location ?? this.location,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}