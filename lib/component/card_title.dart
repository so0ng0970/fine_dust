import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  const CardTitle(
      {required this.title, required this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            16.0,
          ),
          topRight: Radius.circular(
            16.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
