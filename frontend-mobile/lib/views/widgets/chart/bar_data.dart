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
