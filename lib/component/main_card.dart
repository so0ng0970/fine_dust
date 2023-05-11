import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  const MainCard({
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // 추가된 데코레이션이 있기 때문에 shape를 사용해서
      // BorderRadius 사용해야한다
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      color: backgroundColor,
      child: child,
    );
  }
}
