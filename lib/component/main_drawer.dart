import 'package:fine_dust/const/regions.dart';
import 'package:flutter/material.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;
  final Color darkColor;
  final Color lightColor;

  const MainDrawer({
    required this.onRegionTap,
    required this.selectedRegion,
    required this.darkColor,
    required this.lightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              '지역선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          // children이 이미 리스트기 때문에
          // ... 써서 리스트 안에 퍼트려서 또다른 리스트를 넣을 수 있음
          ...regions.map(
            (e) => ListTile(
              tileColor: Colors.white,
              selectedTileColor: lightColor,
              // 글자색
              selectedColor: Colors.black,
              selected: e == selectedRegion,
              onTap: () {
                onRegionTap(e);
              },
              title: Text(e),
            ),
          )
        ],
      ),
    );
  }
}
