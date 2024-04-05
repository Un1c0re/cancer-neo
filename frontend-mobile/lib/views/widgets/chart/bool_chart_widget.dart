
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/widgets/chart/bar_data.dart';
import 'package:diplom/views/widgets/chart/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BoolChart extends StatefulWidget {
  const BoolChart({super.key});

  @override
  State<BoolChart> createState() => _BoolChartState();
}

class _BoolChartState extends State<BoolChart> {
  int pointCounter = 0;
  bool isPointerIncremented = false;
  bool isPointerDecremented = false;
  List<Color> colors = List.filled(8, AppColors.backgroundColor);

  void updateColors() {
    for (int i = 0; i < colors.length; i++) {
      if (i == pointCounter) {
        colors[i] = AppColors.activeColor;
      } else {
        colors[i] = AppColors.backgroundColor;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 150,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: BarChart(
            BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 8,
              
                // showing value while touching bar
                barTouchData: BarTouchData(enabled: false),
                // show border around BarChart
                borderData: FlBorderData(show: false),
              
                // grid
                gridData: const FlGridData(
                  horizontalInterval: 4,
                  verticalInterval: 0.2356,
                ),
              
                // Titles
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 25,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: boolChartleftTitles,
                      reservedSize: 100,
                    ),
                  ),
                ),
              
                // bars values
                barGroups: generateBoolData()),
          ),
        ),
      ),
    );
  }
}