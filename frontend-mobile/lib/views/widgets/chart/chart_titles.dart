import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget gradeChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 18);
  String text;

  switch (value) {
    case 0:
      text = 'Симптом';
      break;
    case 5:
      text = 'Симптом';
      break;
    case 10:
      text = 'Симптом';
    case 15:
      text = 'Симптом';
      break;
    default:
      // text = '${value}';
      text = '';
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      text,
      style: style,
    ),
  );
}

Widget boolChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 18);

  String text;

  switch (value) {
    case 0:
      text = 'Симптом';
      break;
    case 4:
      text = 'Симптом';
      break;
    default:
      text = ' ';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      text,
      style: style,
    ),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
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