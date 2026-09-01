import '../enums/visit_status.dart';

class SyncResult {
  const SyncResult({required this.status, required this.wasOffline});

  final VisitStatus status;
  final bool wasOffline;
}
