import 'package:fine_dust/component/card_title.dart';
import 'package:fine_dust/component/main_card.dart';
import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  const HourlyCard({
    required this.darkColor,
    required this.lightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 미세먼지',
            backgroundColor: darkColor,
          ),
          Column(
            children: List.generate(
              24,
              (index) {
                final now = DateTime.now();
                final hour = now.hour;
                int currentHour = hour - index;
                // 3 2 1 0 23 22 21
                if (currentHour < 0) {
                  currentHour += 24;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          currentHour.toString(),
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'asset/image/good.png',
                          height: 20.0,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          '좋음',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
