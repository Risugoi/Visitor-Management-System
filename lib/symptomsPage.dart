import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vmsvisitor/qrCode.dart';
import 'package:vmsvisitor/styles/styles.dart';
import 'package:vmsvisitor/database/visitordb.dart';
import 'package:path/path.dart' as p;
import 'package:vmsvisitor/temp.dart';

class symptomsProfile extends StatefulWidget {
  @override
  _symptomsProfile createState() => _symptomsProfile();
}

class _symptomsProfile extends State<symptomsProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();
  bool symptom1 = false;
  bool symptom2 = false;
  bool symptom3 = false;
  bool symptom4 = false;
  bool symptom5 = false;
  String symp1;
  String symp2;
  String symp3;
  String symp4;
  String symp5;
  String healthStatus = "";
  String savedDate;
  var _symptoms = [];

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
                            height: 50,
                          ),
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Text(
                                  'Symptoms',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ]),
                              SizedBox(
                                height: 5,
                              ),
                              CheckboxListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 80),
                                title: Text(
                                  'Symptom1',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: this.symptom1,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.symptom1 = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 80),
                                title: Text(
                                  'Symptom2',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: this.symptom2,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.symptom2 = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 80),
                                title: Text(
                                  'Symptom3',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: this.symptom3,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.symptom3 = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 80),
                                title: Text(
                                  'Symptom4',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: this.symptom4,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.symptom4 = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 80),
                                title: Text(
                                  'Symptom5',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: this.symptom5,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.symptom5 = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            width: 170,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                if (symptom1 == true) {
                                  _symptoms.add('symptom1');
                                } else {
                                  _symptoms.add(null);
                                }

                                if (symptom2 == true) {
                                  _symptoms.add('symptom2');
                                } else {
                                  _symptoms.add(null);
                                }

                                if (symptom3 == true) {
                                  _symptoms.add('symptom3');
                                } else {
                                  _symptoms.add(null);
                                }

                                if (symptom4 == true) {
                                  _symptoms.add('symptom4');
                                } else {
                                  _symptoms.add(null);
                                }

                                if (symptom5 == true) {
                                  _symptoms.add('symptom5');
                                } else {
                                  _symptoms.add(null);
                                }

                                if (_symptoms[0] != null) {
                                  symp1 = _symptoms[0];
                                } else {
                                  symp1 = null;
                                }

                                if (_symptoms[1] != null) {
                                  symp2 = _symptoms[1];
                                } else {
                                  symp2 = null;
                                }

                                if (_symptoms[2] != null) {
                                  symp3 = _symptoms[2];
                                } else {
                                  symp3 = null;
                                }

                                if (_symptoms[3] != null) {
                                  symp4 = _symptoms[3];
                                } else {
                                  symp4 = null;
                                }

                                if (_symptoms[4] != null) {
                                  symp5 = _symptoms[4];
                                } else {
                                  symp5 = null;
                                }
                                savedDate = date.toString().substring(0, 10);
                                _insertSymptoms();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => temperature()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Colors.white10,
                              child: Text('Save'),
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
          )),
    );
  }

  _insertSymptoms() async {
    Database db = await visitordb.createInstance().insertInfo();
    Map<String, dynamic> toMap() => {
          "savedDate": savedDate,
          "symp1": symp1,
          "symp2": symp2,
          "symp3": symp3,
          "symp4": symp4,
          "symp5": symp5,
        };
    return await db.insert(visitordb.table2, toMap());
  }
}
