import 'package:fine_dust/model/stat_model.dart';
import 'package:fine_dust/model/status_model.dart';

class StatAndStatusModel {
  // 미세먼지 / 초미세먼지
  final ItemCode itemCode;
  final statusModel status;
  final StatModel stat;

  StatAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.stat,
  });
}
