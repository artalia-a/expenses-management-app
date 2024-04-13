import 'dart:io';

import 'package:my_app/dto/expenses.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseInstance {
  // Define database name
  final String databaseName = "expenses.db";
  final int databaseVersion = 2;

// Define expenses table attributes
  final String tableName = 'expenses';
  final String id = 'id';
  final String total = 'total';
  final String name = 'name';
  final String financialSource = 'financialSource';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    print('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

// Create table schema
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${tableName} ($id INTEGER PRIMARY KEY, $total INTEGER, $name TEXT NULL, $financialSource TEXT NULL,  $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

// Display all list of expenses
  Future<List<ExpensesModel>> getAll() async {
    final db = await database();
    final data = await db.query(tableName, orderBy: '$id DESC');
    List<ExpensesModel> result =
        data.map((e) => ExpensesModel.fromJson(e)).toList();
    return result;
  }

// Add new expenses
  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database(); // Ensure that the database is initialized
    final query = await db.insert(tableName, row);
    return query;
  }

// Count the total of expenses each month
  Future<int> totalExpenses() async {
    final db = await database(); // Ensure that the database is initialized

    // Get the current month and year
    DateTime now = DateTime.now();
    String currentMonthYear = DateFormat('yyyy-MM').format(now);

    // Construct the SQL query with a WHERE clause to filter by the current month
    final query = await db.rawQuery(
        "SELECT SUM(total) as total FROM $tableName WHERE strftime('%Y-%m', $createdAt) = ?",
        [currentMonthYear]);

    // Extract the total from the result
    int total = int.parse(query.first['total'].toString());
    return total;
  }

// Delete expenses
  Future<int> delete(id) async {
    final db = await database();
    final query = await db.delete(tableName, where: '$id = ?', whereArgs: [id]);

    return query;
  }

// Update expenses
  Future<int> update(int id, Map<String, dynamic> row) async {
    final db = await database();
    final query =
        await db.update(tableName, row, where: '$id = ?', whereArgs: [id]);
    return query;
  }

// Show detail of expenses based on the selected id
  Future<ExpensesModel?> getExpenseById(int id) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?', // Corrected the where clause
      whereArgs: [id],
    );

    // Check if the result is not empty
    if (maps.isNotEmpty) {
      // Return the first item in the list as ExpensesModel
      return ExpensesModel.fromJson(maps.first);
    } else {
      // Return null if no matching record is found
      return null;
    }
  }

  // Show recent expenses in the homepage with limit, e.g display only 5 expenses
  Future<List<ExpensesModel>> getRecentExpenses(int limit) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: '$id DESC',
      limit: limit,
    );

    // Convert the List<Map<String, dynamic>> to a List<ExpensesModel>
    return List.generate(maps.length, (i) {
      return ExpensesModel.fromJson(maps[i]);
    });
  }
}
