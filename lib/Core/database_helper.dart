import 'package:path/path.dart';
import 'package:simple_expense_tracker/Core/expense.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance =
  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize Database
  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'expenses.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            amount REAL NOT NULL
          )
        ''');
      },
    );
  }

  // Add Expense
  Future<int> insertExpense(Expense expense) async {
    final db = await database;

    return await db.insert(
      'expenses',
      expense.toMap()..remove('id'),
    );
  }

  // Get Expenses
  Future<List<Expense>> getExpenses() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
    await db.query(
      'expenses',
      orderBy: 'id DESC',
    );

    return List.generate(
      maps.length,
          (index) => Expense.fromMap(maps[index]),
    );
  }

  // Delete Expense
  Future<int> deleteExpense(int id) async {
    final db = await database;

    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}