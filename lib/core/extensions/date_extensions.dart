extension DateExtensions on DateTime {
  String get displayDate {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
}
