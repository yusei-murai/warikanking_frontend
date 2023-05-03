import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FriendUsersInfra{
  Future<Database> openFriendUsersDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'friend_user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE friend_user(user_id TEXT PRIMARY KEY)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertFriendUser(String userId) async {
    Database database = await openFriendUsersDatabase();

    await database.insert(
      'friend_user',
      {'user_id': userId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database.close();
  }

  Future<List<Map<String, dynamic>>> readFriendUser() async {
    Database database = await openFriendUsersDatabase();

    List<Map<String, dynamic>> results = await database.query('friend_user');

    await database.close();

    return results;
  }

  Future<void> updateFriendUser(String userId, String newUserId) async {
    Database database = await openFriendUsersDatabase();

    await database.update(
      'friend_user',
      {'user_id': newUserId},
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    await database.close();
  }

  Future<void> deleteFriendUser(String userId) async {
    Database database = await openFriendUsersDatabase();

    await database.delete(
      'friend_user',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    await database.close();
  }
}