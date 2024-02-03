import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  final String databasePath;

  DatabaseServices(this.databasePath);

  Future<Database> get _db async {
    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE your_table (id TEXT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  Future<bool> insert(String table, Map<String, Object?> values) async {
    final db = await _db;
    try {
      values["toBeSynced"] = true;
      if ((await db.insert(
            table,
            values,
            conflictAlgorithm: ConflictAlgorithm.replace,
          )) >
          0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("SQliteDatabaseError", error: e);
      return false;
    } finally {
      await db.close();
    }
  }

  Future<List<Map<String, dynamic>>?> read(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await _db;
    try {
      return await db.query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      log("SQliteDatabaseError", error: e);
      return null;
    } finally {
      await db.close();
    }
  }

  Future<bool> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await _db;
    try {
      if ((await db.update(
            table,
            values,
            where: where,
            whereArgs: whereArgs,
            conflictAlgorithm: ConflictAlgorithm.replace,
          )) >
          0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("SQliteDatabaseError", error: e);
      return false;
    } finally {
      await db.close();
    }
  }
}
