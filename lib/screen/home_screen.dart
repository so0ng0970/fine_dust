import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:fine_dust/const/regions.dart';
import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';

import '../component/category_card.dart';
import '../component/hourly_card.dart';
import '../component/main_app_bar.dart';
import '../utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();

    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawerScreen(
          selectedRegion: region,
          onRegionTap: (String region) {
            setState(() {
              this.region = region;
              Navigator.of(context).pop();
            });
          }),
      body: FutureBuilder<List<StatModel>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // 에러가 있을때
            return const Center(
              child: Text('에러가 있습니다'),
            );
          }
          if (!snapshot.hasData) {
            // 로딩상태
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<StatModel> stats = snapshot.data!;
          StatModel recentStat = stats[0];
          // 1 - 5 , 6 - 10 , 11 - 15
          // 7
          final status = DataUtils.getStatusFromItemCodeAndValue(
              itemCode: ItemCode.PM10, value: recentStat.seoul);

          return CustomScrollView(
            slivers: [
              MainAppBar(
                region: region,
                stat: recentStat,
                status: status,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    CategoryCard(),
                    SizedBox(
                      height: 16.0,
                    ),
                    HourlyCard(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
