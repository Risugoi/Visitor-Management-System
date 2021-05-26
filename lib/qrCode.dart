import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:vmsvisitor/database/visitordb.dart';

class qrCode extends StatefulWidget {
  final String temp;
  const qrCode({Key key, this.temp}) : super(key: key);
  @override
  _qrCode createState() => _qrCode();
}

class _qrCode extends State<qrCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fName;
  String lName;
  String address;
  String conNum;
  String symptoms1;
  String symptoms2;
  String symptoms3;
  String symptoms4;
  String symptoms5;
  DateTime currentDate = DateTime.now();
  String cDate;

  void initState() {
    super.initState();
    personalData();
    symptomsData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'VMS',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: <Widget>[
                            Center(
                                child: QrImage(
                              data: jsonEncode({
                                "fName": fName,
                                "lName": lName,
                                "address": address,
                                "conNum": conNum,
                                "temp": widget.temp,
                                "symptoms1": symptoms1,
                                "symptoms2": symptoms2,
                                "symptoms3": symptoms3,
                                "symptoms4": symptoms4,
                                "symptoms5": symptoms5,
                              }),
                              version: QrVersions.auto,
                              size: 200,
                              gapless: false,
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: Text(
                            'Health Status: ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void personalData() async {
    var data = await _getData();
    setState(() {
      fName = data["fName"];
      lName = data["lName"];
      address = data["address"];
      conNum = data["conNum"];
    });
  }

  void symptomsData() async {
    cDate = currentDate.toString().substring(0, 10);
    var data2 = await _getSymp();
    if (data2["savedDate"].toString() == cDate) {
      setState(() {
        symptoms1 = data2["symp1"];
        symptoms2 = data2["symp2"];
        symptoms3 = data2["symp3"];
        symptoms4 = data2["symp4"];
        symptoms5 = data2["symp5"];
      });
    } else {
      print("error");
    }
  }

  _getData() async {
    String path = p.join(await getDatabasesPath(), visitordb.dbName);
    var db = await openDatabase(path);
    List<Map> profileRows = await db
        .rawQuery("SELECT COUNT(${visitordb.fName}) FROM ${visitordb.table1}");
    int getProfRows = profileRows[0].values.elementAt(0);
    if (getProfRows > 0) {
      List<Map> personalInfo =
          await db.rawQuery("SELECT * FROM ${visitordb.table1}");
      return personalInfo[0];
    }
  }

  _getSymp() async {
    String path = p.join(await getDatabasesPath(), visitordb.dbName);
    var db = await openDatabase(path);
    List<Map> symptomsRow =
        await db.rawQuery("SELECT * FROM ${visitordb.table2}");
    return symptomsRow[symptomsRow.length - 1];
  }
}
