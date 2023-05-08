import 'package:dio/dio.dart';
import 'package:fine_dust/component/category_card.dart';
import 'package:fine_dust/component/hourly_card.dart';
import 'package:fine_dust/component/main_app_bar.dart';
import 'package:fine_dust/component/main_drawer.dart';
import 'package:fine_dust/const/colors.dart';
import 'package:fine_dust/const/data.dart';
import 'package:fine_dust/model/stat_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response = await Dio().get(
      dataUrl,
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK'
      },
    );
    print(
      response.data['response']['body']['items'].map(
        (item) => StatModel.fromJson(json: item),
      ),
    );
  }

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
      ),
    );
  }
}
