import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper/models/note.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper; //Singelton Databasehelper
  static Database _database; //Singelton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTittle = 'tittle';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if(_databaseHelper==null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database>get database async{

    if(_database==null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path +'note.db';

    var noteDatabase = await openDatabase(path,version: 1,onCreate:_createDb);
    return noteDatabase;
  }

  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTittle TEXT,'
      '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //fetch operation

  Future<List<Map<String,dynamic>>>getNoteMapList()async{
    Database db = await this.database;
    //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable,orderBy: '$colPriority ASC');
    return result;
  }

  //insert
  Future<int>insertNote(Note note)async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }


  //update
  Future<int>updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),where: '$colId=?',whereArgs:[note.id] );
    return result;
  }

  //delete
  Future<int>deleteNote(int id)async{
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //getNumber
  Future<int>getCount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x= await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}