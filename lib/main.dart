import 'package:flutter/material.dart';
import 'package:test_app_ai/test11.dart';
import 'package:test_app_ai/test22.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyImageScreen(),
      // home: PixelColorScreen(),
    );
  }
}

