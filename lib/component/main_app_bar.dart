import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/model/status_model.dart';
import 'package:fine_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String region;
  final statusModel status;
  final StatModel stat;
  final DateTime dataTime;
  final bool isExpanded;

  const MainAppBar(
      {required this.region,
      required this.stat,
      required this.status,
      required this.dataTime,
      required this.isExpanded,
      super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      pinned: true,
      title: isExpanded
          ? null
          : Text(
              '$region ${DataUtils.getTimeFromDateTime(dateTime: dataTime)}'),
      centerTitle: true,
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              // kToolbarHeight AppBar사이즈 만큼 알 수 있다.
              top: kToolbarHeight,
            ),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime)
                      .toString(),
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
