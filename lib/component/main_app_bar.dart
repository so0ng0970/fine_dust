import 'package:fine_dust/const/colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            // kToolbarHeight AppBar사이즈 만큼 알 수 있다.
            top: kToolbarHeight,
          ),
          child: Column(
            children: [
              Text(
                '서울',
                style: ts.copyWith(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateTime.now().toString(),
                style: ts.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'asset/image/mediocre.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                '보통',
                style: ts.copyWith(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '나쁘지 않습니다',
                style: ts.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
