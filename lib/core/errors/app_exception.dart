abstract class AppException implements Exception {
  const AppException({required this.message, this.code});
  final String message;
  final String? code;
  @override
  String toString() {
    if (code == null) return message;
    return '$code: $message';
  }
}

class DatabaseException extends AppException {
  const DatabaseException({required super.message, super.code});
}

class SyncException extends AppException {
  const SyncException({required super.message, super.code});
}
