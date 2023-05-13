import 'package:fine_dust/component/category_card.dart';
import 'package:fine_dust/component/hourly_card.dart';
import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/regions.dart';
import 'package:fine_dust/model/stat_and_status_model.dart';
import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    @override
    dispose() {
      scrollController.removeListener(scrollListener);
      scrollController.dispose();
      super.dispose();
    }
  }

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
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

    //Hive 데이터 넣기
    for (int i = 0; i < results.length; i++) {
      // ItemCode
      final key = ItemCode.values[i];
      // List<StatModel>
      final value = results[i];

      final box = Hive.box<StatModel>(key.name);
      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }
    }
    return ItemCode.values.fold<Map<ItemCode, List<StatModel>>>({},
        (previousValue, itemCode) {
      final box = Hive.box<StatModel>(itemCode.name);
      previousValue.addAll(
        {
          itemCode: box.values.toList(),
        },
      );
      return previousValue;
    });
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // 에러가 있을때
          return const Scaffold(
            body: Center(
              child: Text('에러가 있습니다'),
            ),
          );
        }
        if (!snapshot.hasData) {
          // 로딩상태
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        Map<ItemCode, List<StatModel>> stats = snapshot.data!;
        StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

        // 1 - 5 , 6 - 10 , 11 - 15
        // 7
        // 미세먼지 최근 데이터의 현재 상
        final status = DataUtils.getStatusFromItemCodeAndValue(
          itemCode: ItemCode.PM10,
          value: pm10RecentStat.seoul,
        );

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
        return Scaffold(
          drawer: MainDrawerScreen(
              lightColor: status.lightColor,
              darkColor: status.darkColor,
              selectedRegion: region,
              onRegionTap: (String region) {
                setState(() {
                  this.region = region;
                  Navigator.of(context).pop();
                });
              }),
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  isExpanded: isExpanded,
                  dataTime: pm10RecentStat.dataTime,
                  region: region,
                  stat: pm10RecentStat,
                  status: status,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        models: ssModel,
                        region: region,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ...stats.keys.map((itemCode) {
                        final stat = stats[itemCode]!;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: HourlyCard(
                            category: DataUtils.getItemCodeKrString(
                              itemcode: itemCode,
                            ),
                            stats: stats[ItemCode.PM10]!,
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                        );
                      }).toList(),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
