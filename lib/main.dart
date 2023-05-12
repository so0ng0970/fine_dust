import 'package:fine_dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';
void main() async {
  await Hive.initFlutter();

  await Hive.openBox(testBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'sunflower'),
      home: const TestScreen(),
    );
  }
}
