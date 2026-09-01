import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static const String _databaseName = 'field_visit_log.db';
  static const int _databaseVersion = 1;
  static const String localVisitsTable = 'local_visits';
  static const String visitLogTable = 'visit_log';
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, _databaseName);
    return openDatabase(
      fullPath,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $localVisitsTable (
            id TEXT PRIMARY KEY,
            site_name TEXT NOT NULL,
            date TEXT NOT NULL,
            location TEXT NOT NULL,
            notes TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE $visitLogTable (
            id TEXT PRIMARY KEY,
            site_name TEXT NOT NULL,
            date TEXT NOT NULL,
            location TEXT NOT NULL,
            notes TEXT NOT NULL,
            stage TEXT NOT NULL,
            created_at TEXT NOT NULL,
            synced_at TEXT
          )
        ''');
      },
    );
  }
}
