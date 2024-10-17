import 'package:flutter/material.dart';
import 'package:myapp/models/medicine_model.dart';
import 'package:myapp/models/notification.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static const _databaseName = 'medicine.db';
  static const _databaseVersion = 1;

  static const MedicineTable = 'medicine_table';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnFrequency = 'frequency';

  static const NotificationTable = 'notification_table';
  static const columnIdNotification = 'id';
  static const columnIdMedicine = 'idMedicine';
  static const columnTime = 'time';

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, _databaseName);

    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);

    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $MedicineTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnFrequency INTEGER NOT NULL
      )
''');

    await db.execute('''
  CREATE TABLE $NotificationTable (
    $columnIdNotification INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnIdMedicine INTEGER NOT NULL,
    $columnTime String NOT NULL,
    FOREIGN KEY ($columnIdMedicine) REFERENCES $MedicineTable ($columnId)
  )
''');
  }

  Future<void> insertMedicine(Medicine medicine) async {
    final db = await database;
    await db.insert(
      MedicineTable,
      medicine.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Medicine>> queryAllRowsMedicine() async {
    final db = await database;

    List<Map<String, dynamic>> medicines =
        await db.query(MedicineTable, orderBy: "$columnId DESC");
    return List.generate(
      medicines.length,
      (index) => Medicine(
        id: medicines[index]['id'],
        name: medicines[index]['name'],
        frequency: medicines[index]['frequency'],
      ),
    );
  }

  Future<Medicine> queryOnMedicine(int id) async {
    final db = await database;

    List<Map<String, dynamic>> medicine = await db.query(
      MedicineTable,
      orderBy: "$columnId DESC",
      where: '$columnId == ?',
      whereArgs: [id],
    );

    return Medicine(
      id: medicine[0]['id'],
      name: medicine[0]['name'],
      frequency: medicine[0]['frequency'],
    );
  }

  Future<int> getLastMedicineId() async {
    final db = await database;

    List<Map<String, dynamic>> medicine = await db.query(
      MedicineTable,
      orderBy: "$columnId DESC",
      limit: 1,
    );
    return medicine[0]['id'];
  }

  Future<void> deleteMedicine(int id) async {
    final db = await database;

    await db.delete(MedicineTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> insertNotification(MedicineNotification notification) async {
    final db = await database;
    await db.insert(
      NotificationTable,
      notification.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MedicineNotification>> queryAllRowsNotification() async {
    final db = await database;

    List<Map<String, dynamic>> notifications = await db.query(NotificationTable,
        orderBy: "$columnIdNotification DESC");
    return List.generate(
      notifications.length,
      (index) => MedicineNotification(
        id: notifications[index]['id'],
        idMedicine: notifications[index]['idMedicine'],
        time: notifications[index]['time'],
      ),
    );
  }

  Future<List<MedicineNotification>> getNotificationsByMedicineId(
      int idMedicince) async {
    final db = await database;

    List<Map<String, dynamic>> notifications = await db.query(NotificationTable,
        orderBy: "$columnIdNotification ASC",
        where: '$columnIdMedicine == ?',
        whereArgs: [idMedicince]);
    return List.generate(
      notifications.length,
      (index) => MedicineNotification(
        id: notifications[index]['id'],
        idMedicine: notifications[index]['idMedicine'],
        time: notifications[index]['time'],
      ),
    );
  }

  Future<void> deleteNotificationByMedicineId(int id) async {
    final db = await database;
    await db.delete(
      NotificationTable,
      where: '$columnIdMedicine == ?',
      whereArgs: [id],
    );
  }
}
