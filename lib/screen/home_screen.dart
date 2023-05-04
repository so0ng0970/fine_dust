import 'package:fine_dust/component/card_title.dart';
import 'package:fine_dust/component/category_card.dart';
import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/component/main_card.dart';
import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const MainDrawerScreen(),
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CategoryCard(),
                const SizedBox(
                  height: 16.0,
                ),
                MainCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CardTitle(
                        title: '시간별 미세먼지',
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
