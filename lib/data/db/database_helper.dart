import 'package:helloflutter/data/model/resto_search.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorits';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/favsFeature.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblFavorite( id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DOUBLE)''');
    }, version: 1);

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> addFavorit(Restaurant restaurant) async {
    final db = await database;
    await db?.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getAllFav() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((item) => Restaurant.fromJson(item)).toList();
  }

  Future<Map> getFavByUrl(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
