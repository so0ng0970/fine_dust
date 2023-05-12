import 'package:fine_dust/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Test2Screen extends StatelessWidget {
  const Test2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen2'),
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
        ],
      ),
    );
  }
}
