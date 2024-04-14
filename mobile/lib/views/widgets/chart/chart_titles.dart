import 'package:diplom/services/database_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget gradeChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 14);
  return SideTitleWidget(
      axisSide: meta.axisSide,
      child: FutureBuilder(
        future: Get.find<DatabaseService>()
            .database
            .symptomsNamesDao
            .getSymptomsNamesByTypeID(2),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Загрузка...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final names = snapshot.data!;
            for (int i = 0; i < names.length; i++) {
              if (value == i * 5) {
                return Text(names[i] + ' '*(100-names.length), textAlign: TextAlign.left, style: style);
              }
            }
            return const Text('');
          }
        }),
      ));
}

Widget lineChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1';
      break;
    case 2:
      text = '2';
      break;
    case 3:
      text = '3';
      break;
    case 4:
      text = '5';
      break;
    case 5:
      text = '6';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.start);
}

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
