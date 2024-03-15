import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/widgets/chart/bar_data.dart';
import 'package:diplom/views/widgets/chart/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GradeChart extends StatelessWidget {
  const GradeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 16,

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
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                  getTitlesWidget: gradeChartleftTitles,
                  reservedSize: 100,
                ),
              ),
            ),

            // bars values
            barGroups: generateGradeData(),
          ),
        ),
      ),
    );
  }
}
