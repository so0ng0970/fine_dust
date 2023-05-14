import 'package:fine_dust/component/card_title.dart';
import 'package:fine_dust/component/main_card.dart';
import 'package:fine_dust/component/main_stat.dart';
import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    required this.region,
    required this.darkColor,
    required this.lightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
                  backgroundColor: darkColor,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // 조금만 넘겨도 다음페이지 보여줌
                    physics: const PageScrollPhysics(),
                    children: ItemCode.values
                        .map(
                          (ItemCode itemCode) => ValueListenableBuilder<Box>(
                            valueListenable:
                                Hive.box<StatModel>(itemCode.name).listenable(),
                            builder: (context, box, widget) {
                              final stat = (box.values.last as StatModel);
                              final status =
                                  DataUtils.getStatusFromItemCodeAndValue(
                                itemCode: itemCode,
                                value: stat.getLevelFromRegion(region),
                              );

                              return MainStat(
                                width: constraint.maxWidth / 3,
                                category: DataUtils.getItemCodeKrString(
                                    itemcode: itemCode),
                                imgPath: status.imagePath,
                                level: status.label,
                                stat: '${stat.getLevelFromRegion(
                                  region,
                                )} ${DataUtils.getUnitFromItemCode(
                                  itemcode: itemCode,
                                )}',
                              );
                            },
                          ),
                        )
                        .toList(),
                    // List.generate(
                    //   15,
                    //   (index) => MainStat(
                    //       width: constraint.maxWidth / 3,
                    //       category: '미세먼지 ${index + 1}',
                    //       imgPath: 'asset/image/best.png',
                    //       level: '최고',
                    //       stat: '0㎍/㎥'),
                    // ),
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
