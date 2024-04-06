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

BarChartGroupData gradeChartGroupData(int x, List<double> values) {
  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: values.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      return BarChartRodData(
        fromY: index * 4,
        toY: index * 4 + value,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(value / 4)),
        width: 8,
      );
    }).toList(),
  );
}

BarChartGroupData boolChartGroupData(int x, List<double> values) {
  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: values.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      return BarChartRodData(
        fromY: index * 5,
        toY: index * 5 + 0.5,
        borderSide: const BorderSide(
          color: AppColors.activeColor,
          style: BorderStyle.solid,
        ),
        color: value > 0 ? AppColors.activeColor : Colors.transparent,
        width: 8,
      );
    }).toList(),
  );
}


// BarChartGroupData boolChartGroupData(
//   int x,
//   int symptome1,
//   int symptome2,
// ) {
//   bool value1 = symptome1 != 0;
//   bool value2 = symptome2 != 0;

//   return BarChartGroupData(
//     x: x,
//     groupVertically: true,
//     barRods: [
//       BarChartRodData(
//         fromY: 0,
//         toY: 0.5,
//         borderSide: const BorderSide(
//           color: AppColors.activeColor,
//           style: BorderStyle.solid,
//         ),
//         color: value1 ? AppColors.activeColor : Colors.transparent,
//         width: 8,
//       ),
//       BarChartRodData(
//         fromY: 4,
//         toY: 4.5,
//         borderSide: const BorderSide(
//           color: AppColors.activeColor,
//           style: BorderStyle.solid,
//         ),
//         color: value2 ? AppColors.activeColor : Colors.transparent,
//         width: 8,
//       ),
//     ],
//   );
// }

// List<BarChartGroupData> generateBoolData() {
//   List<BarChartGroupData> groupDataList = [];
//   for (int i = 0; i < 30; i++) {
//     groupDataList
//         .add(boolChartGroupData(i, Random().nextInt(2), Random().nextInt(2)));
//   }
//   return groupDataList;
// }

// class WeekData {
//   final List<double> dataValues;
//   final String dataName;
//   final bool isBoolean;

//   WeekData({
//     required this.isBoolean,
//     required this.dataValues,
//     required this.dataName,
//   });
// }
