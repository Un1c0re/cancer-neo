import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/views/widgets/charts/chart_data.dart';
import 'package:cancerneo/views/widgets/charts/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradeChart extends StatefulWidget {
  final DateTime selectedDate;
  const GradeChart({
    super.key,
    required this.selectedDate,
  });

  @override
  State<GradeChart> createState() => _GradeChartState();
}

class _GradeChartState extends State<GradeChart> {
  late int totalPoints;

  int currentPointIndex = 0;

  List<String> symptomNames = [];

  Future<void> loadSymptomNames() async {
    final names = await Get.find<DatabaseService>()
        .database
        .symptomsNamesDao
        .getSymptomsNamesByTypeID(2);
    setState(() {
      symptomNames = names;
      totalPoints =
          names.length ~/ 2; // Или другая логика для определения totalPoints
    });
  }

  @override
  void initState() {
    super.initState();
    loadSymptomNames(); // Загружаем имена симптомов при инициализации
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    Future<int> getGradeSymptomsNamesCount() async {
      final List<String> tmp =
          await service.database.symptomsNamesDao.getSymptomsNamesByTypeID(2);
      return tmp.length;
    }

    Future<List<List<double>>> getGradeData(DateTime date) async {
      final monthStart = getFirstDayOfMonth(date);
      final monthEnd = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(2, monthStart, monthEnd);

      return rawDataList;
    }

    List<BarChartGroupData> groupData(List<List<double>> rawDataList) {
      // Убедимся, что endIndex не выходит за пределы списка
      int startIndex = currentPointIndex * 4;

      List<List<double>> filteredDataList = rawDataList.map((dayList) {
        int endIndex = startIndex + 4;
        if (dayList.isNotEmpty) {
          endIndex = endIndex < dayList.length ? endIndex : dayList.length;
          return dayList.sublist(startIndex, endIndex);
        }
        return dayList;
      }).toList();

      List<BarChartGroupData> groupDataList = [];
      for (int i = 0; i < filteredDataList.length; i++) {
        groupDataList.add(gradeChartGroupData(i, filteredDataList[i]));
      }

      return groupDataList;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 315,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 45),
              child: FutureBuilder(
                  future: getGradeSymptomsNamesCount(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.activeColor,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      totalPoints = snapshot.data! ~/ 4;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.keyboard_arrow_up),
                            onPressed: () {
                              currentPointIndex > 0
                                  ? currentPointIndex--
                                  : currentPointIndex = totalPoints - 1;
                              setState(() {});
                            },
                            iconSize: 28,
                          ),
                          Text(
                            '${currentPointIndex + 1}/$totalPoints',
                            style: const TextStyle(fontSize: 14),
                          ),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onPressed: () {
                              currentPointIndex < totalPoints - 1
                                  ? currentPointIndex++
                                  : currentPointIndex = 0;
                              setState(() {});
                            },
                            iconSize: 28,
                          ),
                        ],
                      );
                    }
                  })),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: FutureBuilder<List<List<double>>>(
                  future: getGradeData(pickedDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.activeColor,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<List<double>> rawData = snapshot.data!;
                      final List<BarChartGroupData> barData =
                          groupData(rawData);

                      return BarChart(BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,

                        // showing value while touching bar
                        barTouchData: BarTouchData(enabled: false),

                        // show border around BarChart
                        borderData: FlBorderData(show: false),

                        // grid
                        gridData: const FlGridData(
                          horizontalInterval: 5,
                          verticalInterval: 0.23,
                        ),

                        // Titles
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitlesWidget,
                              reservedSize: 25,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(fontSize: 14);
                                int startIndex = currentPointIndex * 4;
                                int endIndex = currentPointIndex * 4 + 4;
                                endIndex = endIndex < symptomNames.length
                                    ? endIndex
                                    : symptomNames.length;
                                List<String> titlesData =
                                    symptomNames.sublist(startIndex, endIndex);
                                for (int i = 0; i < titlesData.length; i++) {
                                  if (value == i * 5) {
                                    return Text(titlesData[i], style: style);
                                  }
                                }
                                return const Text('');
                              },
                              reservedSize: 85,
                            ),
                          ),
                        ),
                        // bars values
                        barGroups: barData,
                      ));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
