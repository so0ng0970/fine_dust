import 'package:fine_dust/container/category_card.dart';
import 'package:fine_dust/container/hourly_card.dart';
import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/regions.dart';
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
    fetchData();

    @override
    dispose() {
      scrollController.removeListener(scrollListener);
      scrollController.dispose();
      super.dispose();
    }
  }

  Future<void> fetchData() async {
    final now = DateTime.now();
    final fetchTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final box = Hive.box<StatModel>(ItemCode.PM10.name);
    final recent = box.values.last;

    if (recent.dataTime.isAtSameMomentAs(fetchTime)) {
      print('이미 데이터 있음 ');
      return;
    }

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
      final allKeys = box.keys.toList();
      if (allKeys.length > 24) {
        // start 시작 인덱스 , end - 끝 인덱스
        final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
        box.deleteAll(deleteKeys);
      }
    }
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
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        // PM10 (미세먼지)
        // box.value.toList().first
        final recentStat = box.values.toList().last as StatModel;
        // 미세먼지 최근 데이터의 현재 상태
        final status = DataUtils.getStatusFromItemCodeAndValue(
          itemCode: ItemCode.PM10,
          value: recentStat.getLevelFromRegion(region),
        );
        return Scaffold(
          drawer: MainDrawer(
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
                  dataTime: recentStat.dataTime,
                  region: region,
                  stat: recentStat,
                  status: status,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ...ItemCode.values.map((itemCode) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: HourlyCard(
                            itemCode: itemCode,
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
