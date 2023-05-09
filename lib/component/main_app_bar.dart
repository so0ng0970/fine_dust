import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/model/status_model.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final statusModel status;
  final StatModel stat;

  const MainAppBar({required this.stat, required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            // kToolbarHeight AppBar사이즈 만큼 알 수 있다.
            top: kToolbarHeight,
          ),
          child: Column(
            children: [
              Text(
                '서울',
                style: ts.copyWith(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getTimeFromDateTime(dateTime: stat.dataTime).toString(),
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
    );
  }

  getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${getTimeFormat(dateTime.month)}-${getTimeFormat(dateTime.day)} ${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }
}
