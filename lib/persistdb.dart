
import 'package:food/explore.dart';
import 'package:food/home.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        role TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""
      CREATE TABLE food(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        foodName TEXT,
        foodDonor TEXT,
        foodFileName TEXT,
        latitude REAL,
        longitude REAL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }
  // id: the id of a user
// username, role: name and role of your activity
// created_at: the time that the user was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'food.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new user
  static Future<int> createuser(String username, String? descrption) async {
    Get.to(const HomePage());
    final db = await SQLHelper.db();

    final data = {'username': username, 'role': descrption};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all users
  static Future<List<Map<String, dynamic>>> getusers() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: "id");
  }

// Read a single user by id
// The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getuser(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //update user by id
  static Future<int> updateuser(int id, String username, String? role) async {
    final db = await SQLHelper.db();

    final data = {
      'username': username,
      'role': role,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Create new food
  static Future<int> createFood(String foodName, String foodDonor,
      String? foodFileName, double? latitude, double? longitude) async {
    Get.to(const Explore());
    final db = await SQLHelper.db();

    final data = {
      'foodName': foodName,
      'foodDonor': foodDonor,
      'foodFileName': foodFileName,
      'latitude': latitude,
      'longitude': longitude,
    };

    final id = await db.insert('food', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all foods
  static Future<List<Map<String, dynamic>>> getFoods() async {
    final db = await SQLHelper.db();
    return db.query('food', orderBy: "id");
  }

  //Delete
  static Future<void> deleteuser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an user: $err");
    }
  }
}
