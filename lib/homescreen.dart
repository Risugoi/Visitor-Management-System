import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vmsstores/api.dart';
import 'package:vmsstores/styles/style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class homeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey qrKey = GlobalKey();
  var data;
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
  String temp;
  var _symptoms = [];
  var qrText = "";
  var qrText2 = "";
  var sendAPI = [];

  String fName;
  String lName;
  String address;
  String cNum;

  //controllers
  final _fNameCon = new TextEditingController();
  final _lNameCon = new TextEditingController();
  final _addCon = new TextEditingController();
  final _cNumCon = new TextEditingController();
  final _tempCon = new TextEditingController();
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(children: <Widget>[
                Expanded(
                  //flex: 8,
                  flex: 1,
                  child: QRView(
                    key: qrKey,
                    overlay: QrScannerOverlayShape(
                        borderRadius: 10,
                        borderColor: Colors.red,
                        borderLength: 20,
                        borderWidth: 10,
                        cutOutSize: 300),
                    onQRViewCreated: _onQRViewCreate,
                  ),
                ),
                /*
                Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                        ),
                        Text('Temperature: '),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: textBox,
                          height: 40,
                          width: 100,
                          child: TextFormField(
                              controller: _tempCon,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 2.0, bottom: 2.0, left: 1.0),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Temperature is required';
                                } else {
                                  setState(() {
                                    temp = value;
                                  });
                                  return null;
                                }
                              }),
                        ),
                      ],
                    )),
                    */
              ]),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text('First Name'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                  controller: _fNameCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'First name is required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Last Name'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                  controller: _lNameCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Last name is required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Address'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                  controller: _addCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Contact Number'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                  controller: _cNumCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'First name is required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Temperature'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                  controller: _tempCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Temperature is required';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text('Symptoms'),
                          ]),
                          CheckboxListTile(
                            title: Text('Symptom1'),
                            value: this.symptom1,
                            onChanged: (bool value) {
                              setState(() {
                                this.symptom1 = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Symptom2'),
                            value: this.symptom2,
                            onChanged: (bool value) {
                              setState(() {
                                this.symptom2 = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Symptom3'),
                            value: this.symptom3,
                            onChanged: (bool value) {
                              setState(() {
                                this.symptom3 = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Symptom4'),
                            value: this.symptom4,
                            onChanged: (bool value) {
                              setState(() {
                                this.symptom4 = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Symptom5'),
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
                        height: 50,
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () async {
                            fName = _fNameCon.text;
                            lName = _lNameCon.text;
                            address = _addCon.text;
                            cNum = _cNumCon.text;
                            temp = _tempCon.text;

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
                              symp1 = "-";
                            }

                            if (_symptoms[1] != null) {
                              symp2 = _symptoms[1];
                            } else {
                              symp2 = "-";
                            }

                            if (_symptoms[2] != null) {
                              symp3 = _symptoms[2];
                            } else {
                              symp3 = "-";
                            }

                            if (_symptoms[3] != null) {
                              symp4 = _symptoms[3];
                            } else {
                              symp4 = "-";
                            }

                            if (_symptoms[4] != null) {
                              symp5 = _symptoms[4];
                            } else {
                              symp5 = "-";
                            }
                            savedDate = date.toString().substring(0, 10);

                            /*
                            sendAPI.add(savedDate);
                            sendAPI.add(fName);
                            sendAPI.add(lName);
                            sendAPI.add(address);
                            sendAPI.add(cNum);
                            sendAPI.add(temp);
                            sendAPI.add(symp1);
                            sendAPI.add(symp2);
                            sendAPI.add(symp3);
                            sendAPI.add(symp4);
                            sendAPI.add(symp5);
                            print(sendAPI);
                            sendData(sendAPI);
                            data = await Getdata(url);
                            */
                            sendData(savedDate, fName, lName, address, cNum,
                                temp, symp1, symp2, symp3, symp4, symp5);
                          },
                          child: Text('Continue'),
                          textColor: Colors.black,
                          color: Colors.white10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        if (qrText != "") {
          if (qrText != qrText2) {
            qrText2 = qrText;
            print(qrText);
            qrData(qrText);
            controller.pauseCamera();
            sleep(Duration(seconds: 3));
            controller.resumeCamera();
          }
        }
      });
    });
  }

  Future<http.Response> sendData(
      String date,
      String fName,
      String lName,
      String address,
      String cNum,
      String temp,
      String symp1,
      String symp2,
      String symp3,
      String symp4,
      String symp5) {
    return http.post(
      Uri.parse('http://10.0.2.2:5000'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'date': date,
        'fName': fName,
        'lName': lName,
        'address': address,
        'cNum': cNum,
        'temp': temp,
        'symp1': symp1,
        'symp2': symp2,
        'symp3': symp3,
        'symp4': symp4,
        'symp5': symp5
      }),
    );
  }

  Future<http.Response> qrData(String qrText) {
    savedDate = date.toString().substring(0, 10);
    List data = [];
    List fData = [];
    qrText.split(',').forEach((i) {
      i.split(':').forEach((j) {
        data.add(j);
      });
    });
    for (int i = 0; i < data.length; i++) {
      if (i % 2 != 0) {
        fData.add(data[i]);
      }
    }
    return http.post(Uri.parse('http://10.0.2.2:5000'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'date': savedDate,
          'fName': fData[0],
          'lName': fData[1],
          'address': fData[2],
          'cNum': fData[3],
          'temp': fData[4],
          'symp1': fData[5],
          'symp2': fData[6],
          'symp3': fData[7],
          'symp4': fData[8],
          'symp5': fData[9]
        }));
  }
}
