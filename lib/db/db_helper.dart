import 'package:my_posyandu/model/posyandu.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String tableName = 'tableJudul';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnTtl = 'ttl';
  final String columnAlamat = 'alamat';
  final String columnKeterangan = 'keterangan';

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'posyandu_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnNama TEXT,"
        "$columnTtl TEXT,"
        "$columnAlamat TEXT,"
        "$columnKeterangan TEXT)";
    await db.execute(sql);
  }

  Future<int?> savePosyandu(Posyandu posyandu) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, posyandu.toMap());
  }

  Future<List?> getAllPosyandu() async {
    var dbClient = await _db;
    var result = await dbClient!
        .query(tableName, columns: [columnId, columnNama, columnTtl, columnAlamat, columnKeterangan]);
    return result.toList();
  }

  Future<int?> updatePosyandu (Posyandu posyandu) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, posyandu.toMap(),
        where: '$columnId = ?', whereArgs: [posyandu.id]);
  }

  Future<int?> deletePosyandu (int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}