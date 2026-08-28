enum VisitStatus {
  draft('draft'),
  synced('synced'),
  failed('failed');

  const VisitStatus(this.value);

  final String value;

  static VisitStatus fromString(String value) {
    return VisitStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => VisitStatus.draft,
    );
  }
}
