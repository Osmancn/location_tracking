import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;
  static DatabaseService? _databaseService;

  factory DatabaseService() {
    _databaseService ??= DatabaseService._initiliaze();

    return _databaseService!;
  }

  DatabaseService._initiliaze() {}

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "LocationTracking.db");
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "db", "LocationTracking.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    _database = await openDatabase(path, readOnly: false);
    return _database!;
  }
}
