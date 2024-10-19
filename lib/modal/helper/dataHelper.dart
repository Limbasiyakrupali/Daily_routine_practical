import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "first.db");

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE IF NOT EXISTS habbits(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, time TEXT NOT NULL, completed INTEGER DEFAULT 0)";
        db.execute(query);
      },
    );
  }

  Future<void> addDb(String title, String time) async {
    if (database != null) {
      String query = "INSERT INTO habbits(title,time) VALUES(?,?);";
      await database!.rawInsert(query, [title, time]);
    } else {
      await initDB();
    }
  }

  Future<List<Map<String, dynamic>>> fetchHabits() async {
    if (database != null) {
      String query = "SELECT * FROM habbits;";
      return await database!.rawQuery(query);
    }
    return [];
  }

  Future<void> updateHabit(int id) async {
    if (database != null) {
      String query = "UPDATE habbits SET completed = ? WHERE id = ?;";
      List args = [id];
      await database!.rawUpdate(query, args);
    }
  }

  Future<void> removeDB(int id) async {
    if (database != null) {
      String query = "DELETE FROM habbits WHERE id=?;";
      await database!.rawDelete(query, [id]);
    }
  }

  Future<void> removeAllDB() async {
    if (database != null) {
      String query = "DELETE FROM habbits;";
      await database!.rawDelete(query);
    }
  }
}
