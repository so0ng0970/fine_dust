import 'package:fine_dust/component/card_title.dart';
import 'package:fine_dust/component/main_card.dart';
import 'package:fine_dust/component/main_stat.dart';
import 'package:fine_dust/model/stat_and_status_model.dart';
import 'package:fine_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;
  const CategoryCard({
    required this.models,
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
                    children: models
                        .map(
                          (model) => MainStat(
                            width: constraint.maxWidth / 3,
                            category: DataUtils.getItemCodeKrString(
                                itemcode: model.itemCode),
                            imgPath: model.status.imagePath,
                            level: model.status.label,
                            stat: '${model.stat.getLevelFromRegion(
                              region,
                            )} ${DataUtils.getUnitFromItemCode(
                              itemcode: model.itemCode,
                            )}',
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
