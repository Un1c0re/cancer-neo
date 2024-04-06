import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/datetime_helpers.dart';
import 'package:diplom/views/widgets/chart/bar_data.dart';
import 'package:diplom/views/widgets/chart/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BoolChart extends StatefulWidget {
  final DateTime selectedDate;
  const BoolChart({super.key, required this.selectedDate});

  @override
  State<BoolChart> createState() => _BoolChartState();
}

class _BoolChartState extends State<BoolChart> {

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    Future<List<BarChartGroupData>> getBoolData(DateTime date) async {
      final monthStart = getFirstDayOfMonth(date);
      final monthEnd = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(1, monthStart, monthEnd);

      List<BarChartGroupData> groupDataList = [];
      for (int i = 0; i < rawDataList.length; i++) {
        groupDataList.add(boolChartGroupData(i, rawDataList[i]));
      }

      return groupDataList;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 350,
              ),
              child: FutureBuilder<List<BarChartGroupData>>(
                future: getBoolData(pickedDate),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<BarChartGroupData> barData = snapshot.data!;
                    return BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 30,

                        // showing value while touching bar
                        barTouchData: BarTouchData(enabled: false),
                        // show border around BarChart
                        borderData: FlBorderData(show: false),

                        // grid
                        gridData: const FlGridData(
                          horizontalInterval: 5,
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
                        barGroups: barData,
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
