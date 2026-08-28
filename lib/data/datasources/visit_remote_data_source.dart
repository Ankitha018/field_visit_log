import 'dart:math';

enum MockSyncResult { synced, draft, failed }

class VisitRemoteDataSource {
  VisitRemoteDataSource({Random? random}) : _random = random ?? Random();

  final Random _random;

  Future<MockSyncResult> syncVisit() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final results = MockSyncResult.values;

    return results[_random.nextInt(results.length)];
  }
}
