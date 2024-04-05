
import 'dart:math';

import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Text('Рецепторы соматостатина',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 5),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250,
              ),
              child: LineChart(
                sampleData2,
                duration: const Duration(milliseconds: 250),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 30,
        maxY: 6,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: true,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
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

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        reservedSize: 32,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
      switch (value.toInt()) {
    case 0:
      text = const Text('01');
      break;
    case 7:
      text = const Text('08');
      break;
    case 15:
      text = const Text('15');
      break;
    case 22:
      text = const Text('22');
      break;
    case 29:
      text = const Text('29');
      break;
    default:
      text = const Text('');
      break;
  }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData {
    return const FlGridData(
    show: true,
    horizontalInterval: 1,
  );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(30, (index) {
          return FlSpot(index.toDouble(), 0.5 + Random().nextDouble()*4);
        })
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {

  @override
  Widget build(BuildContext context) {
    return MyLineChart();
  }
}