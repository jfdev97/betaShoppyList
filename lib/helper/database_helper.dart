import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shoppylist/model/item_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String itemTables = 'item_tables';
  String colId = 'id';
  String colName = 'name';
  String colNote = 'note';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database> get db async {
    
    if (_db == null) {
      _db = await _initDb();
    }

    return _db;
  }

  Future<Database> _initDb() async {

    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'shoppy_list.db';

    final shoppyListDb = await openDatabase(path, version: 1, onCreate: _createDb);

    return shoppyListDb;
  }

  void _createDb(Database db, int version) async {

    await db.execute(
      'CREATE TABLE $itemTables($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colNote TEXT, $colPriority text, $colStatus INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getItemMapList() async {

    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(itemTables);

    return result;
  }

  Future<List<Item>> getItemList() async {
    
    final List<Map<String, dynamic>> itemMapList = await getItemMapList();
    final List<Item> itemList = [];

    itemMapList.forEach((itemMap) {
      itemList.add(Item.fromMap(itemMap));
    });

    return itemList;
  }

  Future<int> insertItem(Item item) async {

    Database db = await this.db;
    final int result = await db.insert(itemTables, item.toMap());

    return result;
  }

  Future<int> updateItem(Item item) async {

    Database db = await this.db;

    final int result = await db.update(
      itemTables,
      item.toMap(),
      where: '$colId = ?',
      whereArgs: [item.id],
    );

    return result;
  }

  Future<int> deleteItem(int id) async {

    Database db = await this.db;

    final int result = await db.delete(
      itemTables,
      where: '$colId = ?',
      whereArgs: [id],
    );

    return result;
  }
}