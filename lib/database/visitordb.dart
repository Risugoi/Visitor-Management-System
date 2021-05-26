import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class visitordb {
  visitordb.createInstance();

  static final dbName = "visitordb.db";
  static final table1 = "visitorInfo";
  static final table2 = "Symptoms";

  //columns inside table1
  static final fName = "fName";
  static final lName = "lName";
  static final address = "address";
  static final conNum = "conNum";

  //columns inside table2
  static final savedDate = "savedDate";
  static final symp1 = "symp1";
  static final symp2 = "symp2";
  static final symp3 = "symp3";
  static final symp4 = "symp4";
  static final symp5 = "symp5";

  //create database
  Future<Database> createVisitorDB() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table1(fName, lName, address, conNum)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table2(savedDate, symp1, symp2, symp3, symp4, symp5)");
  }

  //insert to database
  Future<Database> insertInfo() async {
    String path = p.join(await getDatabasesPath(), dbName);
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
