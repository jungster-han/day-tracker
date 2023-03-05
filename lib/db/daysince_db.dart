import 'package:daysince/models/daysince_detail.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DaysinceDatabase {
  static final DaysinceDatabase instance = DaysinceDatabase._init();
  static Database? _database;
  DaysinceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('daysince.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''
      CREATE TABLE $daysinceDetailTableName (
        ${DaysinceDetailFields.id} $idType,
        ${DaysinceDetailFields.description},
        ${DaysinceDetailFields.startingDate}
      )
      ''');
  }

  Future<DaysinceDetail> addDaysince(DaysinceDetail detail) async {
    final db = await instance.database;
    final id = await db.insert(daysinceDetailTableName, detail.toJson());
    return detail.copy(id: id);
  }

  Future<DaysinceDetail> getDaysince(int id) async {
    final db = await instance.database;
    final maps = await db.query(daysinceDetailTableName,
        columns: DaysinceDetailFields.columns,
        where: '${DaysinceDetailFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return DaysinceDetail.fromJson(maps.first);
    } else {
      throw Exception('id $id was not found');
    }
  }

  Future<List<DaysinceDetail>> getAllDaysince() async {
    final db = await instance.database;
    final result = await db.query(daysinceDetailTableName);

    return result.map((json) => DaysinceDetail.fromJson(json)).toList();
  }

  Future<int> updateDaysince(DaysinceDetail daysince) async {
    final db = await instance.database;

    return db.update(daysinceDetailTableName, daysince.toJson(),
        where: '${DaysinceDetailFields.id} = ?', whereArgs: [daysince.id]);
  }

  Future<int> removeDaysince(int id) async {
    final db = await instance.database;

    return db.delete(daysinceDetailTableName,
        where: '${DaysinceDetailFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {}
}
