import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' hide DatabaseException;

import '../../core/errors/app_exception.dart';
import '../models/visit_model.dart';

class VisitLocalDataSource {
  static const String _databaseName = 'field_visit.db';
  static const int _databaseVersion = 1;

  static const String localVisitsTable = 'local_visits';
  static const String visitLogTable = 'visit_log';

  Database? _database;

  Future<Database> get _db async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();

      final path = join(
        databasesPath,
        _databaseName,
      );

      return openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (database, version) async {
          await database.execute('''
            CREATE TABLE $localVisitsTable (
              id TEXT PRIMARY KEY,
              date TEXT NOT NULL,
              location TEXT NOT NULL,
              note TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');

          await database.execute('''
            CREATE TABLE $visitLogTable (
              id TEXT PRIMARY KEY,
              date TEXT NOT NULL,
              location TEXT NOT NULL,
              note TEXT NOT NULL,
              stage TEXT NOT NULL,
              created_at TEXT NOT NULL,
              synced_at TEXT
            )
          ''');
        },
      );
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to open local database.',
        code: 'DATABASE_OPEN_ERROR',
      );
    }
  }

  Future<void> insertLocalVisit(
      VisitModel visit,
      ) async {
    try {
      final database = await _db;

      await database.insert(
        localVisitsTable,
        visit.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to save visit locally.',
        code: 'LOCAL_INSERT_ERROR',
      );
    }
  }

  Future<List<VisitModel>> getLocalVisits() async {
    try {
      final database = await _db;

      final rows = await database.query(
        localVisitsTable,
        orderBy: 'created_at DESC',
      );

      return rows
          .map(VisitModel.fromLocalMap)
          .toList();
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to read local visits.',
        code: 'LOCAL_READ_ERROR',
      );
    }
  }

  Future<void> deleteLocalVisit(
      String id,
      ) async {
    try {
      final database = await _db;

      await database.delete(
        localVisitsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to delete local visit.',
        code: 'LOCAL_DELETE_ERROR',
      );
    }
  }

  Future<void> insertVisitLog(
      VisitModel visit,
      ) async {
    try {
      final database = await _db;

      await database.insert(
        visitLogTable,
        visit.toLogMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to write visit log.',
        code: 'LOG_INSERT_ERROR',
      );
    }
  }

  Future<List<VisitModel>> getVisitLog() async {
    try {
      final database = await _db;

      final rows = await database.query(
        visitLogTable,
        orderBy: 'created_at DESC',
      );

      return rows
          .map(VisitModel.fromLogMap)
          .toList();
    } catch (_) {
      throw const DatabaseException(
        message: 'Unable to read visit log.',
        code: 'LOG_READ_ERROR',
      );
    }
  }

  Future<bool> localVisitExists(
      String id,
      ) async {
    final database = await _db;

    final rows = await database.query(
      localVisitsTable,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return rows.isNotEmpty;
  }
}