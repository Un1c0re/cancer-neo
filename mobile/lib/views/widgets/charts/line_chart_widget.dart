import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LineChartWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Color lineColor;
  final int typeID;
  const LineChartWidget({
    super.key,
    required this.selectedDate,
    required this.lineColor,
    required this.typeID,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late int totalPoints;
  int currentPointIndex = 0;
  List<String> symptomsNames = [];
  List<double> symptomsMaxValues = [0];

  Future<void> loadSymptomNames() async {
    final names = await Get.find<DatabaseService>()
        .database
        .symptomsNamesDao
        .getSymptomsNamesByTypeID(widget.typeID);
    setState(() {
      symptomsNames = names;
      totalPoints = names.length;
    });
  }

  Future<void> loadSymptomsMaxVlues() async {
    final List<double> maxValues = [];
    for (int i = 0; i < symptomsNames.length; i++) {
      maxValues.add(await Get.find<DatabaseService>()
          .database
          .symptomsValuesDao
          .getMaxValueByName(symptomsNames[i]));
    }
    setState(() {
      symptomsMaxValues = maxValues;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSymptomNames().then((_) {
      loadSymptomsMaxVlues();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (symptomsNames.isEmpty) return const SizedBox();
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    Future<List<List<double>>> getLineData(DateTime date) async {
      final monthStart = getFirstDayOfMonth(date);
      final monthEnd = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(widget.typeID, monthStart, monthEnd);

      return rawDataList;
    }

    List<LineChartBarData> groupData(List<List<double>> rawDataList) {
      // Создаем список точек для графика, используя текущий индекс точки
      List<FlSpot> spots = [];
      for (int index = 0; index < rawDataList.length; index++) {
        // Берем значение для текущего индекса точки, или 0 если оно отсутствует
        double value = rawDataList[index].length > currentPointIndex
            ? rawDataList[index][currentPointIndex]
            : 0.0;
        if (value != 0.0) {
          // Filter out zero values
          spots.add(FlSpot(index.toDouble(), value));
        }
      }

      // Создаем данные для графика из точек
      LineChartBarData lineData = LineChartBarData(
        isCurved: true,
        curveSmoothness: 0.2,
        barWidth: 1,
        isStrokeCapRound: true,
        color: widget.lineColor,
        dotData: FlDotData(
          checkToShowDot: (spot, barData) => spot.y != 0.0,
          show: true,
          getDotPainter: (FlSpot spot, double percent, LineChartBarData barData,
              int index) {
            return FlDotCirclePainter(
              radius: 3.5,
              color: widget.lineColor,
              strokeColor: Colors.transparent,
              strokeWidth: 0,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: spots,
        // другие настройки для LineChartBarData...
      );

      // Возвращаем список с одной линией данных
      return [lineData];
    }

    Future<int> getLineSymptomsNamesCount() async {
      final List<String> tmp = await service.database.symptomsNamesDao
          .getSymptomsNamesByTypeID(widget.typeID);
      return tmp.length;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 360),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 45,
              ),
              child: FutureBuilder(
                future: getLineSymptomsNamesCount(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    totalPoints = snapshot.data!;
                    if (totalPoints <= 1) return const SizedBox();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
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
                }),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  symptomsNames.isNotEmpty
                      ? symptomsNames[currentPointIndex]
                      : 'Загрузка...',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 250,
                    maxWidth: 360,
                  ),
                  child: FutureBuilder(
                    future: getLineData(pickedDate),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.activeColor,
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final List<List<double>> rawData = snapshot.data!;
                        final List<LineChartBarData> lineData =
                            groupData(rawData);
                        return LineChart(
                          LineChartData(
                            minY: 0,
                            minX: 0,
                            maxX: 31,
                            // show border around BarChart
                            borderData: FlBorderData(show: false),
                            lineTouchData: LineTouchData(
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor:
                                    Colors.blueGrey.withOpacity(0.8),
                                getTooltipItems:
                                    (List<LineBarSpot> touchedSpots) {
                                  return touchedSpots
                                      .map((LineBarSpot touchedSpot) {
                                    return LineTooltipItem(
                                      '${touchedSpot.y}',
                                      const TextStyle(
                                          color: Colors
                                              .white), // Set text color here
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            // grid
                            gridData: const FlGridData(
                              drawHorizontalLine: true,
                              horizontalInterval: 3,
                              drawVerticalLine: true,
                              verticalInterval: 5,
                            ),
                            titlesData: FlTitlesData(
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  // getTitlesWidget: bottomTitlesWidget,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    for (int i = 0; i < 31; i++) {
                                      if (value == i * 5) {
                                        return Text(
                                          '${value.toInt() + 1}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        );
                                      }
                                    }
                                    return const SizedBox();
                                  },
                                  reservedSize: 25,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    double maxValue = symptomsMaxValues[
                                        currentPointIndex]; // Предполагаем, что это максимальное значение
                                    if (value >= 0 &&
                                        value <= maxValue &&
                                        value % 5 == 0) {
                                      // Проверяем, что значение кратно 5 и находится в пределах от 0 до maxValue
                                      return Text(
                                        '${value.toInt()}',
                                        style: const TextStyle(fontSize: 14),
                                      );
                                    }
                                    return const Text('');
                                  },
                                  reservedSize: 25,
                                ),
                              ),
                            ),
                            lineBarsData: lineData,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
