import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_model.dart';

class DBHelper {

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {

    String path =
    join(await getDatabasesPath(), 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          date TEXT
        )
        ''');

      },
    );
  }

  /// INSERT
  Future<int> insertUser(User user) async {

    final db = await database;

    return db.insert('users', user.toMap());
  }

  /// PAGINATION + ID FILTER + DATE FILTER
  Future<List<User>> getUsersPaginated({

    required int limit,
    required int offset,
    int? startId,
    int? endId,
    String? startDate,
    String? endDate,

  }) async {

    final db = await database;

    List<String> conditions = [];
    List<dynamic> args = [];

    if (startId != null && endId != null) {

      conditions.add('id BETWEEN ? AND ?');
      args.addAll([startId, endId]);

    }

    if (startDate != null && endDate != null) {

      conditions.add('date BETWEEN ? AND ?');
      args.addAll([startDate, endDate]);

    }

    String? where =
    conditions.isEmpty ? null : conditions.join(' AND ');

    final maps = await db.query(

      'users',
      where: where,
      whereArgs: args,
      limit: limit,
      offset: offset,
      orderBy: 'date DESC',

    );

    return maps
        .map((e) => User.fromMap(e))
        .toList();
  }

  /// UPDATE
  Future<int> updateUser(User user) async {

    final db = await database;

    return db.update(
      'users',
      user.toMap(),
      where: 'id=?',
      whereArgs: [user.id],
    );
  }

  /// DELETE
  Future<int> deleteUser(int id) async {

    final db = await database;

    return db.delete(
      'users',
      where: 'id=?',
      whereArgs: [id],
    );
  }

}