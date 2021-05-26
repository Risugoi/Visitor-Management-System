import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmsvisitor/database/visitordb.dart';
import 'package:vmsvisitor/start.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatelessWidget {
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => visitordb.createInstance().createVisitorDB());

    return new SplashScreen(
      seconds: 1,
      navigateAfterSeconds: new Home(),
      title: new Text(
        "VMS",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.green,
    );
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return start();
  }
}
