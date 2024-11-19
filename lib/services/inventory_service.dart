import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modal/inventory_modal.dart';

class InventoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static Database? _database;

  Future<Database> get _sqliteDb async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'inventory.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id TEXT PRIMARY KEY,
        name TEXT,
        quantity INTEGER,
        category TEXT
      )
    ''');
  }


  Future<void> addItem(Item item) async {
    try {
      await _db.collection('inventory').add(item.toMap());
      final db = await _sqliteDb;
      await db.insert('items', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Error adding item: $e");
    }
  }


  Stream<List<Item>> getItems() {
    return _db.collection('inventory').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    });
  }


  Future<List<Item>> getItemsFromSQLite() async {
    final db = await _sqliteDb;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        quantity: maps[i]['quantity'],
        category: maps[i]['category'],
      );
    });
  }

  Future<void> updateItem(Item item) async {
    try {
      await _db.collection('inventory').doc(item.id).update(item.toMap());
      final db = await _sqliteDb;
      await db.update(
        'items',
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } catch (e) {
      print("Error updating item: $e");
    }
  }


  Future<void> deleteItem(String id) async {
    try {
      await _db.collection('inventory').doc(id).delete();
      final db = await _sqliteDb;
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error deleting item: $e");
    }
  }
}
