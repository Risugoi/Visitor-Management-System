import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmsvisitor/styles/styles.dart';
import 'package:vmsvisitor/qrCode.dart';

class temperature extends StatefulWidget {
  @override
  _temperature createState() => _temperature();
}

class _temperature extends State<temperature> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String temp;
  //controllers
  final _tempCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('a');
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
                          height: 140,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Enter Temperature:'),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  decoration: textBox,
                                  height: 40,
                                  width: 180,
                                  child: TextFormField(
                                    controller: _tempCon,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: 2.0,
                                            bottom: 10.0,
                                            left: 20.0,
                                            right: 20.0),
                                        hintText: "Enter your Temperature",
                                        hintStyle: TextStyle(
                                            fontSize: 13, color: Colors.grey)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Temperature is required';
                                      }
                                      return null;
                                    },
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                        ),
                        Container(
                          width: 170,
                          height: 40,
                          child: RaisedButton(
                            onPressed: () {
                              temp = _tempCon.text;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => qrCode(
                                            temp: temp,
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            color: Colors.white10,
                            child: Text("Generate QR Code"),
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
  }
}
