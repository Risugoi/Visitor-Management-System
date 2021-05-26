import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmsstores/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
          )));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homeScreen();
  }
}
