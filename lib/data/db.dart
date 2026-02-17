import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
          )
        ''');
      },
    );
  }

  /// INSERT
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  /// GET ALL
  Future<List<User>> getUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('users');

    return maps.map((e) => User.fromMap(e)).toList();
  }

  /// UPDATE
  Future<int> updateUser(User user) async {
    final db = await database;

    return await db.update(
      'users',
      user.toMap(),
      where: 'id=?',
      whereArgs: [user.id],
    );
  }

  /// DELETE
  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete(
      'users',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
