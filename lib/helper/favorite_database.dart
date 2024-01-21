import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDatabaseHelper {
  static Database? _database;
  static const String favoritesTableName = 'favorites';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  static void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $favoritesTableName (
        id TEXT PRIMARY KEY
      )
    ''');
  }

  // Favorites Operations

  static Future<void> saveFavorites(List<String> favorites) async {
    final db = await database;
    await db.delete(
        favoritesTableName); // Hapus entri lama sebelum menyimpan yang baru
    for (var id in favorites) {
      await db.insert(favoritesTableName, {'id': id});
    }
  }

  static Future<List<String>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(favoritesTableName);
    return List.generate(maps.length, (i) {
      return maps[i]['id'].toString();
    });
  }

  static Future<void> insertFavorite(String id) async {
    final db = await database;
    await db.insert(favoritesTableName, {'id': id});
  }

  static Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(favoritesTableName, where: 'id = ?', whereArgs: [id]);
  }
}
