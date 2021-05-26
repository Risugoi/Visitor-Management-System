import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vmsvisitor/qrCode.dart';
import 'package:vmsvisitor/styles/styles.dart';
import 'package:vmsvisitor/symptomsPage.dart';
import 'package:vmsvisitor/database/visitordb.dart';
import 'package:path/path.dart' as p;
import 'package:vmsvisitor/temp.dart';

class visitorProfile extends StatefulWidget {
  @override
  _visitorProfile createState() => _visitorProfile();
}

class _visitorProfile extends State<visitorProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool status = false;
  String fName;
  String lName;
  String address;
  String cNum;

  //controllers
  final _fNameCon = new TextEditingController();
  final _lNameCon = new TextEditingController();
  final _addCon = new TextEditingController();
  final _cNumCon = new TextEditingController();

  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    if (status == false) {
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
                            height: 30,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'First Name',
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _fNameCon,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 10.0,
                                              left: 20.0),
                                          hintText: "Enter your First Name",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'First name is required';
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Last Name'),
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _lNameCon,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 10.0,
                                              left: 20.0),
                                          hintText: "Enter your Last Name",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Last name is required';
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Home Address'),
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _addCon,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 10.0,
                                              left: 20.0),
                                          hintText: "Enter your Home Address",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Address is required';
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Contact Number'),
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _cNumCon,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 10.0,
                                              left: 20.0),
                                          hintText: "Enter your Contact Number",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Contact Number is required';
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                fName = _fNameCon.text;
                                lName = _lNameCon.text;
                                address = _addCon.text;
                                cNum = _cNumCon.text;
                                _insertPersonalInfo();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            symptomsProfile()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Colors.white10,
                              child: Text("Save"),
                              textColor: Colors.black,
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
    } else {
      return temperature();
    }
  }

  _insertPersonalInfo() async {
    Database db = await visitordb.createInstance().insertInfo();
    Map<String, dynamic> toMap() => {
          "fName": fName,
          "lName": lName,
          "address": address,
          "conNum": cNum,
        };
    return await db.insert(visitordb.table1, toMap());
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
}
