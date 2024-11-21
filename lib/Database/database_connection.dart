import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projectuts/Module/user.dart';

class DatabaseConnection {
  static final DatabaseConnection instance = DatabaseConnection._init();

  static Database? _database;

  DatabaseConnection._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const userTable = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      email TEXT,
      password TEXT
    )
    ''';
    await db.execute(userTable);
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    final result = await db.query('users', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}