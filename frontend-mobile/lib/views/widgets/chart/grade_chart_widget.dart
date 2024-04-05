import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/datetime_helpers.dart';
import 'package:diplom/views/widgets/chart/bar_data.dart';
import 'package:diplom/views/widgets/chart/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradeChart extends StatelessWidget {
  final DateTime selectedDate;
  const GradeChart({
    super.key, 
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    Future<List<BarChartGroupData>> getGradeData(DateTime date) async {
      final monthStart  = getFirstDayOfMonth(date);
      final monthEnd    = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(2, monthStart, monthEnd);

      List<BarChartGroupData> groupDataList = [];
      for (int i = 0; i < rawDataList.length; i++) {
        groupDataList.add(gradeChartGroupData1(i, rawDataList[i]));
      }

      return groupDataList;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: FutureBuilder<List<BarChartGroupData>>(
            future: getGradeData(pickedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final List<BarChartGroupData> barData = snapshot.data!;

                return BarChart(BarChartData(
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
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                  barGroups: barData,
                ));
              }
            }),
      ),
    );
  }
}
