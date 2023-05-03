import 'package:fine_dust/component/main_stat.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
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
        color: lightColor,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16.0,
                      ),
                      topRight: Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '종류별 통계',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // 조금만 넘겨도 다음페이지 보여줌
                    physics: const PageScrollPhysics(),
                    children: List.generate(
                      15,
                      (index) => MainStat(
                          width: constraint.maxWidth / 3,
                          category: '미세먼지 $index',
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
