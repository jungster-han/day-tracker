import 'package:daysince/models/daysince.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DaysinceDatabase {
  static final DaysinceDatabase instance = DaysinceDatabase._init();

  static Database? _database;

  DaysinceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('daysinces.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $daysinceTable ( 
  ${DaysinceFields.id} $idType,
  ${DaysinceFields.description} $textType,
  ${DaysinceFields.startDate} $textType
  )
''');
  }

  Future<Daysince> create(Daysince daysince) async {
    final db = await instance.database;
    final id = await db.insert(daysinceTable, daysince.toJson());
    return daysince.copy(id: id);
  }

  Future<Daysince> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      daysinceTable,
      columns: DaysinceFields.values,
      where: '${DaysinceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Daysince.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Daysince>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${DaysinceFields.startDate} ASC';
    final result = await db.query(daysinceTable, orderBy: orderBy);

    return result.map((json) => Daysince.fromJson(json)).toList();
  }

  Future<int> update(Daysince daysince) async {
    final db = await instance.database;

    return db.update(
      daysinceTable,
      daysince.toJson(),
      where: '${DaysinceFields.id} = ?',
      whereArgs: [daysince.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      daysinceTable,
      where: '${DaysinceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
