import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:fine_dust/const/regions.dart';
import 'package:fine_dust/model/stat_and_status_model.dart';
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
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(
          itemCode: itemCode,
        ),
      );
    }
    // 한번에 기다릴 수 있음
    final results = await Future.wait(futures);
    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];
      stats.addAll({key: value});
    }
    return stats;
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
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
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
          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

          // 1 - 5 , 6 - 10 , 11 - 15
          // 7
          final status = DataUtils.getStatusFromItemCodeAndValue(
              itemCode: ItemCode.PM10, value: pm10RecentStat.seoul);

          final ssModel = stats.keys.map((key) {
            final value = stats[key]!;
            // 첫번째 통계
            final stat = value[0];
            return StatAndStatusModel(
              itemCode: key,
              status: DataUtils.getStatusFromItemCodeAndValue(
                value: stat.getLevelFromRegion(region),
                itemCode: key,
              ),
              stat: stat,
            );
          }).toList();
          return CustomScrollView(
            slivers: [
              MainAppBar(
                region: region,
                stat: pm10RecentStat,
                status: status,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CategoryCard(models: ssModel, region: region),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const HourlyCard(),
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
