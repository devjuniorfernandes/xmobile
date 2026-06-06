import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'task_model.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      date INTEGER NOT NULL,
      time INTEGER,
      duration INTEGER,
      done INTEGER DEFAULT 0,
      createdAt INTEGER
    )
    ''');
  }

  Future<TaskModel> create(TaskModel task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toMap());
    task.id = id;
    return task;
  }

  Future<List<TaskModel>> getTasksForDay(DateTime date) async {
    final db = await instance.database;
    final start = DateTime(
      date.year,
      date.month,
      date.day,
    ).millisecondsSinceEpoch;
    final end = DateTime(
      date.year,
      date.month,
      date.day,
      23,
      59,
      59,
    ).millisecondsSinceEpoch;

    final maps = await db.query(
      'tasks',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start, end],
      orderBy: 'time ASC, createdAt ASC',
    );

    return maps.map((m) => TaskModel.fromMap(m)).toList();
  }

  Future<int> update(TaskModel task) async {
    final db = await instance.database;
    return db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
