import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
        ],
      ),
    );
  }
}
