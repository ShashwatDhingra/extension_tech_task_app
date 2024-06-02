import 'dart:ffi';

import 'package:extension_tech_task_app/models/checkin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PrefHelper {
  static const String IS_CHECKIN = 'is_checkin';

  static SharedPreferences? _pref;

  static final PrefHelper _instance = PrefHelper._privateConstructor();

  // Add a static flag to ensure initialization only happens once
  static bool _initialized = false;

  PrefHelper._privateConstructor() {
    if (!_initialized) {
      throw Exception('Call initSharedPref() before using PrefHelper');
    }
  }

  factory PrefHelper() {
    return _instance;
  }

  static Future<void> initSharedPref() async {
    if (!_initialized) {
      _pref = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref!.setBool(key, value);
  }

  bool? getBool(String key){
    return _pref!.getBool(key);
  }

  Future<void> updateCheckInStatus(bool value)async{
    await setBool(PrefHelper.IS_CHECKIN, value);
  }
}

class DBHelper {
  static const String APP_DB = 'app-database';
  static const String CHECKIN_TABLE = 'checkin_table';

  static Database? _db;

  // Private Contructor
  DBHelper._privateConstructor();

  // Singleton instance
  static final DBHelper _instatce = DBHelper._privateConstructor();

  // Getter to access the singleton instance
  factory DBHelper() {
    return _instatce;
  }

  Future<Database> get getDatabase async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), '$APP_DB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $CHECKIN_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, employee TEXT, employee_name TEXT, log_type TEXT, time TEXT, custom_latitude TEXT, custom_longitude TEXT, synced INTEGER DEFAULT 0)');
  }

  Future<void> insertCheckIn(CheckInModel data) async {
    final db = await getDatabase;
    await db.insert(
      CHECKIN_TABLE,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CheckInModel>> getCheckIns() async {
    final db = await getDatabase;
    final List<Map<String, dynamic>> data = await db.query(CHECKIN_TABLE);
    return data.map((item) => CheckInModel.fromMap(item)).toList();
  }

  Future<List<CheckInModel>> getPendingCheckIns() async {
    final db = await getDatabase;
    final List<Map<String, dynamic>> data =
        await db.query(CHECKIN_TABLE, where: "synced = 0");

    return data.map((item) => CheckInModel.fromMap(item)).toList();
  }

  Future<void> deleteCheckIn(int id) async {
    final db = await getDatabase;
    await db.delete(
      CHECKIN_TABLE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> markAsSynced(int id) async {
    final db = await getDatabase;
    await db.update(
      CHECKIN_TABLE,
      {'synced': 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> clearDatabase()async{
    final db = await getDatabase;
    db.delete(CHECKIN_TABLE);
  }
}
