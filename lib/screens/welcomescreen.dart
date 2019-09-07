import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:news_api_lession/screens/newsscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                child: Center(child: Image.asset("assets/images/Logo.png"))),
            SpinKitRing(
              color: Colors.orangeAccent,
              size: 50.0,
//          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            )
          ],
        ),
      ),
    );
  }
}
