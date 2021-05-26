import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:vmsvisitor/infoPage.dart';
import 'package:vmsvisitor/database/visitordb.dart';
import 'package:vmsvisitor/qrCode.dart';
import 'package:vmsvisitor/symptomsPage.dart';
import 'package:vmsvisitor/temp.dart';

class start extends StatefulWidget {
  @override
  _start createState() => _start();
}

class _start extends State<start> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool status = false;
  String dateSaved;
  DateTime currentDate = DateTime.now();
  String cDate;

  void initState() {
    super.initState();
    info();
    date();
  }

  @override
  Widget build(BuildContext context) {
    cDate = currentDate.toString().substring(0, 10);

    if (status == true) {
      if (cDate == dateSaved) {
        print('Input Temperature screen');
        return temperature();
      }
      if (cDate != dateSaved) {
        print('symptoms screen');
        return symptomsProfile();
      }
    }
    if (status == false) {
      print('registerProfileScreen');
      return visitorProfile();
    }
  }

  void info() async {
    try {
      bool stat = await _getInfo();
      setState(() {
        status = stat;
      });
    } catch (e) {
      setState(() {
        status = false;
      });
    }
  }

  void date() async {
    try {
      String d = await _getDate();
      setState(() {
        dateSaved = d;
      });
    } catch (e) {
      print(e);
    }
  }

  _getInfo() async {
    String path = p.join(await getDatabasesPath(), visitordb.dbName);
    var db = await openDatabase(path);
    try {
      List<Map> numRows = await db.rawQuery(
          "SELECT COUNT(${visitordb.fName}) FROM ${visitordb.table1}");
      int getNum = numRows[0].values.elementAt(0);
      if (getNum < 1) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      setState(() {
        status = false;
      });
    }
  }

  _getDate() async {
    String path = p.join(await getDatabasesPath(), visitordb.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db.rawQuery(
        "SELECT COUNT (${visitordb.savedDate}) FROM ${visitordb.table2}");
    int getNum = numRows[0].values.elementAt(0);
    if (getNum > 0) {
      List<Map> date = await db
          .rawQuery("SELECT ${visitordb.savedDate} FROM ${visitordb.table2}");
      return date[date.length - 1].values.toString().substring(1, 11);
    } else {
      print("no saved date");
    }
  }
}
