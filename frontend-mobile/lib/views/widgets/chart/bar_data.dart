import 'dart:math';

import 'package:diplom/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SymptomeData {
  final List<double> values;
  final String name;
  final bool isBoolean;

  SymptomeData({
    required this.isBoolean,
    required this.values,
    required this.name,
  });
}

class SymptomeBarData {
  List<SymptomeData> symptomeData = [];

  void initializeData() {
    symptomeData = [
    SymptomeData(
        values: [0, 1, 0, 2, 2, 1, 0],
        name: 'Слабость, утомляемость',
        isBoolean: false),
    SymptomeData(
        values: [1, 1, 2, 0, 3, 3, 1],
        name: 'Болевой синдром',
        isBoolean: false),
    SymptomeData(
        values: [0, 1, 0, 1, 2, 1, 3],
        name: 'Депрессия, тревога',
        isBoolean: false),
    SymptomeData(
        values: [2, 3, 1, 1, 1, 1, 0],
        name: 'Мигрень',
        isBoolean: false),
    SymptomeData(
        values: [0, 1, 0, 1, 0, 0, 1], 
        name: 'Рвота', 
        isBoolean: true),
    SymptomeData(
        values: [0, 1, 0, 1, 0, 0, 1],
        name: 'Уменьшение диуреза',
        isBoolean: true),
    SymptomeData(
        values: [1, 1, 1, 0, 1, 1, 1],
        name: 'Ухудшение памяти',
        isBoolean: true),
    SymptomeData(
        values: [0, 1, 0, 1, 1, 1, 0],
        name: 'Нарушение моторных функций',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0], name: 'Хрипы', isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Бронхоспазм',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Боль в левой части грудной клетки',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Аритмия',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Спутанность сознания (химический мозг)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Спутанность сознания (прилив жара к верхней части туловища)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Нейродермит (сыпь, зуд)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Стоматит',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Невропатия руки',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Невропатия ноги',
        isBoolean: true),
    ];
  }
}


BarChartGroupData gradeChartGroupData(
  int x,
  double symptome1,
  double symptome2,
  double symptome3,
  double symptome4,
) {
  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: symptome1,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome1 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 4,
        toY: 4 + symptome2,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome2 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 8,
        toY: 8 + symptome3,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome3 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 12,
        toY: 12 + symptome4,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome4 / 4)),
        width: 8,
      ),
    ],
  );
}

BarChartGroupData boolChartGroupData(
  int x,
  int symptome1,
  int symptome2,
) {
  bool value1 = symptome1 != 0;
  bool value2 = symptome2 != 0;

  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: 0.5,
        borderSide: const BorderSide(
          color: AppColors.activeColor,
          style: BorderStyle.solid,
        ),
        color: value1 ? AppColors.activeColor : Colors.transparent,
        width: 8,
      ),
      BarChartRodData(
        fromY: 4,
        toY: 4.5,
        borderSide: const BorderSide(
          color: AppColors.activeColor,
          style: BorderStyle.solid,
        ),
        color: value2 ? AppColors.activeColor : Colors.transparent,
        width: 8,
      ),
    ],
  );
}

List<BarChartGroupData> generateGradeData() {
  List<BarChartGroupData> groupDataList = [];
  for (int i = 0; i < 30; i++) {
    groupDataList.add(gradeChartGroupData(
        i,
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble()));
  }
  return groupDataList;
}

List<BarChartGroupData> generateBoolData() {
  List<BarChartGroupData> groupDataList = [];
  for (int i = 0; i < 30; i++) {
    groupDataList
        .add(boolChartGroupData(i, Random().nextInt(2), Random().nextInt(2)));
  }
  return groupDataList;
}


class WeekData {
  final List<double> dataValues;
  final String dataName;
  final bool isBoolean;

  WeekData({
    required this.isBoolean,
    required this.dataValues,
    required this.dataName,
  });
}
