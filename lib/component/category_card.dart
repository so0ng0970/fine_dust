import 'package:fine_dust/component/card_title.dart';
import 'package:fine_dust/component/main_card.dart';
import 'package:fine_dust/component/main_stat.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CardTitle(title: '종류별 통계'),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // 조금만 넘겨도 다음페이지 보여줌
                    physics: const PageScrollPhysics(),
                    children: List.generate(
                      15,
                      (index) => MainStat(
                          width: constraint.maxWidth / 3,
                          category: '미세먼지 ${index + 1}',
                          imgPath: 'asset/image/best.png',
                          level: '최고',
                          stat: '0㎍/㎥'),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
