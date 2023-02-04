import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const dbName = 'disneylandDB';
  static const dbVersion = 1;

  static const userTable = 'userTable';
  static const userId = 'user_id';
  static const username = 'user_name';
  static const userPassword = 'user_password';

  static const characterTable = 'characterTable';
  static const characterId = 'character_id';
  static const characterName = 'character_name';
  static const characterPicture = 'character_picture';

  static const voteTable = 'voteTable';
  static const voteId = 'vote_id';
  static const voteDay = 'vote_day';
  static const voteDate = 'vote_date';
  static const voteTime = 'vote_time';

  static final DatabaseHelper instance = DatabaseHelper();

  Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path,
        version: dbVersion, onConfigure: _onConfigure, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable(
        $userId INTEGER PRIMARY KEY,
        $username TEXT NOT NULL,
        $userPassword TEXT NOT NULL 
      )
      ''');
    await db.execute('''
      CREATE TABLE $characterTable(
        $characterId INTEGER PRIMARY KEY,
        $characterName TEXT NOT NULL,
        $characterPicture TEXT
      )
      ''');
    await db.execute('''
      CREATE TABLE $voteTable(
        $voteId INTEGER PRIMARY KEY,
        $voteDay TEXT NOT NULL,
        $voteDate TEXT NOT NULL,
        $voteTime TEXT NOT NULL,
        $userId INTEGER,
        $characterId INTEGER,
        FOREIGN KEY ($characterId) REFERENCES $characterTable ($characterId) ON DELETE NO ACTION ON UPDATE NO ACTION,
        FOREIGN KEY ($userId) REFERENCES $userTable ($userId) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    ''');
  }

  insertUser(Map<String, dynamic> raw) async {
    Database? db = await instance.database;
    return await db!.insert(userTable, raw);
  }

  Future<List<Map<String, dynamic>>> readUsers() async {
    Database? db = await instance.database;
    return await db!.query(userTable);
  }

  updateUser(Map<String, dynamic> raw, previous) async {
    Database? db = await instance.database;
    // print(name);
    return await db!
        .update(userTable, raw, where: '$userId = ?', whereArgs: [previous]);
  }

  insertCharacter(Map<String, dynamic> raw) async {
    Database? db = await instance.database;
    return await db!.insert(characterTable, raw);
  }

  Future<List<Map<String, dynamic>>> readCharacters() async {
    Database? db = await instance.database;
    return await db!.query(characterTable);
  }

  updateCharacter(Map<String, dynamic> raw, previous) async {
    Database? db = await instance.database;
    // print(name);
    return await db!.update(characterTable, raw,
        where: '$characterId = ?', whereArgs: [previous]);
  }

  castVote(Map<String, dynamic> raw) async {
    Database? db = await instance.database;
    return await db!.insert(voteTable, raw);
  }

  Future<List<Map<String, dynamic>>> readVotes() async {
    Database? db = await instance.database;
    return await db!.query(voteTable);
  }

  Future<List<Map<String, dynamic>>> readVotesBetweenDates(
      String? start, String? end) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> result = await db!.query(
      voteTable,
      where: '$voteDate BETWEEN ? AND ?',
      whereArgs: [start, end],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> readVotesOnCharacterId(
      List<int>? ids) async {
    String idString = '(' + ids!.join(',') + ')';
    Database? db = await instance.database;
    final List<Map<String, dynamic>> result = await db!.query(
      voteTable,
      where: '$characterId IN $idString',
    );
    return result;
  }
}
