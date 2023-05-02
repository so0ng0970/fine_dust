import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/component/main_stat.dart';
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
              Card(
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
                child: Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/image/best.png',
                            level: '최고',
                            stat: '0㎍/㎥'),
                        MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/image/best.png',
                            level: '최고',
                            stat: '0㎍/㎥'),
                        MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/image/best.png',
                            level: '최고',
                            stat: '0㎍/㎥')
                      ],
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
