import 'package:sqflite/sqflite.dart';

import '../models/visit_model.dart';

class VisitLocalDataSource {
  VisitLocalDataSource(this._database);

  final Database _database;

  static const String localVisitsTable = 'local_visits';
  static const String visitLogTable = 'visit_log';

  Future<void> insertLocalVisit(VisitModel visit) async {
    await _database.insert(
      localVisitsTable,
      visit.toLocalVisitMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VisitModel>> getLocalVisits() async {
    final rows = await _database.query(
      localVisitsTable,
      orderBy: 'created_at DESC',
    );

    return rows.map(VisitModel.fromMap).toList();
  }

  Future<VisitModel?> getLocalVisit(String id) async {
    final rows = await _database.query(
      localVisitsTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return VisitModel.fromMap(rows.first);
  }

  Future<bool> localVisitExists(String id) async {
    final rows = await _database.query(
      localVisitsTable,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return rows.isNotEmpty;
  }

  Future<void> deleteLocalVisit(String id) async {
    await _database.delete(localVisitsTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertVisitLog(VisitModel visit) async {
    await _database.insert(
      visitLogTable,
      visit.toVisitLogMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VisitModel>> getVisitLogs() async {
    final rows = await _database.query(
      visitLogTable,
      orderBy: 'created_at DESC',
    );

    return rows.map(VisitModel.fromMap).toList();
  }

  Future<VisitModel?> getVisitLog(String id) async {
    final rows = await _database.query(
      visitLogTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return VisitModel.fromMap(rows.first);
  }
}
