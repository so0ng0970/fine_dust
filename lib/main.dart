import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';
void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  await Hive.openBox(testBox);

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'sunflower'),
      home: const HomeScreen(),
    );
  }
}
