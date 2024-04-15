import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


Widget bottomTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 15);
  String date;

  switch (value.toInt()) {
    case 0:
      date = '01';
      break;
    case 7:
      date = '08';
      break;
    case 15:
      date = '15';
      break;
    case 22:
      date = '22';
      break;
    case 29:
      date = '29';
      break;
    default:
      date = '';
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(date, style: style),
  );
}
