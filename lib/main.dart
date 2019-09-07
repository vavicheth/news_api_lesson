import 'package:flutter/material.dart';
import 'package:news_api_lession/screens/welcomescreen.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      home: WelcomeScreen(),
    );
  }
}
