import 'package:fine_dust/main.dart';
import 'package:fine_dust/screen/test2_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, Widget) {
              return Column(
                children: box.values.map((e) => Text(e.toString())).toList(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys : ${box.keys.toList()}');
              print('value : ${box.values.toList()}');
            },
            child: const Text('박스 프린트하기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              box.put(1000, '새로운데이터.....!');
            },
            child: const Text(
              '데이터 넣기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print(box.getAt(0));
            },
            child: const Text(
              '특정값 가져오기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              box.delete(1000);
            },
            child: const Text('데이터 삭제하기!'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Test2Screen(),
                  ),
                );
              },
              child: const Text('다른화면 이동'))
        ],
      ),
    );
  }
}
