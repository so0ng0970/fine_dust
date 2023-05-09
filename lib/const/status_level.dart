/*
  * 1) 최고
  *
  * 미세먼지 : 0-15
  * 초미세먼지 : 0-8
  * 오존(O3) : 0-0.02
  * 이산화질소(NO2) : 0-0.02
  * 일산화탄소(CO) : 0-0.02
  * 아황산가스(SO2) : 0-0.01
  *
  * 2) 좋음
  *
  * 미세먼지 : 16-30
  * 초미세먼지 : 9-15
  * 오존 : 0.02 - 0.03
  * 이산화질소 : 0.02-0.03
  * 일산화탄소 : 1-2
  * 아황산가스 : 0.01-0.02
  *
  * 3) 양호
  *
  * 미세먼지 : 31-40
  * 초미세먼지 : 16-20
  * 오존 : 0.03-0.06
  * 이산화질소 : 0.03-0.05
  * 일산화탄소 : 2-5.5
  * 아황산가스 : 0.02-0.04
  *
  * 4) 보통
  *
  * 미세먼지 : 41-50
  * 초미세먼지 : 21-25
  * 오존 : 0.06-0.09
  * 이산화질소 : 0.05-0.06
  * 일산화탄소 : 5.5-9
  * 아황산가스 : 0.04-0.05
  *
  * 5) 나쁨
  *
  * 미세먼지 : 51-75
  * 초미세먼지 : 26-37
  * 오존 : 0.09-0.12
  * 이산화질소 : 0.06-0.13
  * 일산화탄소 : 9-12
  * 아황산가스 : 0.05-0.1
  *
  * 6) 상당히나쁨
  *
  * 미세먼지 : 76-100
  * 초미세먼지 : 38-50
  * 오존 : 0.12-0.15
  * 이산화질소 : 0.13-0.2
  * 일산화탄소 : 12-15
  * 아황산가스 : 0.1-0.15
  *
  * 7) 매우 나쁨
  *
  * 미세먼지 : 101-150
  * 초미세먼지 : 51-75
  * 오존 : 0.15-0.38
  * 이산화질소 : 0.2-1.1
  * 일산화탄소 : 15-32
  * 아황산가스 : 0.15-0.16
  *
  * 8) 최악
  *
  * 미세먼지 : 151~
  * 초미세먼지 : 76~
  * 오존 : 0.38~
  * 이산화질소 : 1.1~
  * 일산화탄소 : 32~
  * 아황산가스 : 0.16~
  * */

import 'package:fine_dust/model/status_model.dart';
import 'package:flutter/material.dart';

final statusLevel = [
  statusModel(
      level: 0,
      label: '최고등급',
      primaryColor: const Color(0xFF2196F3),
      darkColor: const Color(0xFF0069C0),
      lightColor: const Color(0xFF6EC6FF),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/best.png',
      comment: '우와! 100년에 한번 오는 날! ',
      minFineDust: 0,
      minCO: 0,
      minNO2: 0,
      minO3: 0,
      minSO2: 0,
      minUltraFineDust: 0),
  statusModel(
      level: 1,
      label: '좋음',
      primaryColor: const Color(0xFF03a9f4),
      darkColor: const Color(0xFF007ac1),
      lightColor: const Color(0xFF67daff),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/good.png',
      comment: '공기가 좋아요! 외부활동 해도 좋아요!',
      minFineDust: 16,
      minCO: 1,
      minNO2: 0.02,
      minO3: 0.02,
      minSO2: 0.01,
      minUltraFineDust: 9),
  statusModel(
      level: 2,
      label: '양',
      primaryColor: const Color(0xFF00bcd4),
      darkColor: const Color(0xFF008ba3),
      lightColor: const Color(0xFF62efff),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/ok.png',
      comment: '공기가 좋은 날이예요!',
      minFineDust: 31,
      minCO: 2,
      minNO2: 0.03,
      minO3: 0.03,
      minSO2: 0.02,
      minUltraFineDust: 16),
  statusModel(
      level: 2,
      label: '양호',
      primaryColor: const Color(0xFF00bcd4),
      darkColor: const Color(0xFF008ba3),
      lightColor: const Color(0xFF62efff),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/ok.png',
      comment: '공기가 좋은 날이예요!',
      minFineDust: 31,
      minCO: 2,
      minNO2: 0.03,
      minO3: 0.03,
      minSO2: 0.02,
      minUltraFineDust: 16),
  statusModel(
      level: 3,
      label: '보통',
      primaryColor: const Color(0xFF009688),
      darkColor: const Color(0xFF00675b),
      lightColor: const Color(0xFF52c7b8),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/mediocre.png',
      comment: '나쁘지 않네요!',
      minFineDust: 41,
      minCO: 5.5,
      minNO2: 0.05,
      minO3: 0.06,
      minSO2: 0.04,
      minUltraFineDust: 21),
  statusModel(
      level: 4,
      label: '나쁨',
      primaryColor: const Color(0xFFffc107),
      darkColor: const Color(0xFFc79100),
      lightColor: const Color(0xFFfff350),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/bad.png',
      comment: '공기가 안좋아요...',
      minFineDust: 51,
      minCO: 9,
      minNO2: 0.06,
      minO3: 0.09,
      minSO2: 0.05,
      minUltraFineDust: 26),
  statusModel(
      level: 5,
      label: '상당히 나쁨',
      primaryColor: const Color(0xFFff9800),
      darkColor: const Color(0xFFc66900),
      lightColor: const Color(0xFFffc947),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/very_bad.png',
      comment: '공기가 나빠요! 외부활동을 자제해주세요',
      minFineDust: 76,
      minCO: 12,
      minNO2: 0.13,
      minO3: 0.12,
      minSO2: 0.1,
      minUltraFineDust: 38),
  statusModel(
      level: 6,
      label: '매우 나쁨',
      primaryColor: const Color(0xFFf44336),
      darkColor: const Color(0xFFba000d),
      lightColor: const Color(0xFFff7961),
      detailFontColor: Colors.black,
      imagePath: 'asset/image/worse.png',
      comment: '매우 안좋아요! 나가지 마세요!',
      minFineDust: 101,
      minCO: 15,
      minNO2: 0.2,
      minO3: 0.15,
      minSO2: 0.15,
      minUltraFineDust: 51),
  statusModel(
      level: 7,
      label: '최악',
      primaryColor: const Color(0xFF212121),
      darkColor: const Color(0xFF000000),
      lightColor: const Color(0xFF484848),
      detailFontColor: Colors.white,
      imagePath: 'asset/image/worst.png',
      comment: '역대급 최악의날! 집에만 계세요!',
      minFineDust: 151,
      minCO: 32,
      minNO2: 1.1,
      minO3: 0.38,
      minSO2: 0.16,
      minUltraFineDust: 76),
];
