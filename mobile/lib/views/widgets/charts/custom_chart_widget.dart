import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/views/widgets/charts/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomChartWidget extends StatefulWidget {
  final DateTime selectedDate;
  const CustomChartWidget({super.key, required this.selectedDate});

  @override
  State<CustomChartWidget> createState() => _CustomChartWidgetState();
}

class _CustomChartWidgetState extends State<CustomChartWidget> {
  late int totalPoints;
  int currentPointIndex = 0;
  List<String> symptomsNames = [];
  List<double> symptomsMaxValues = [0];

  Future<void> loadSymptomsNames() async {
    final names = await Get.find<DatabaseService>()
        .database
        .symptomsNamesDao
        .getSymptomsNamesByTypeID(5);
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
    loadSymptomsNames().then((_) {
      loadSymptomsMaxVlues();
    });
  }

  List<Widget> _buildPoints() {
    List<Widget> points = [];
    for (int i = 0; i < totalPoints; i++) {
      points.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentPointIndex = i;
              // Тут можно вызвать функцию, которая обновит данные
            });
          },
          child: Container(
            width: 150 / totalPoints, // Ширина точки
            height: 5, // Высота точки
            margin: const EdgeInsets.symmetric(
                horizontal: 2), // Расстояние между точками
            decoration: BoxDecoration(
              color: i == currentPointIndex
                  ? AppColors.activeColor
                  : AppColors.backgroundColor,
            ),
          ),
        ),
      );
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    if (symptomsNames.isEmpty) return const SizedBox(height: 1);
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    Future<List<List<double>>> getLineData(DateTime date) async {
      final monthStart = getFirstDayOfMonth(date);
      final monthEnd = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(5, monthStart, monthEnd);

      return rawDataList;
    }

    List<LineChartBarData> groupData(List<List<double>> rawDataList) {
      // Создаем список точек для графика, используя текущий индекс точки
      List<FlSpot> spots = List.generate(rawDataList.length, (index) {
        // Берем значение для текущего индекса точки, или 0 если оно отсутствует
        double value = rawDataList[index].length > currentPointIndex
            ? rawDataList[index][currentPointIndex]
            : 0.0;
        return FlSpot(index.toDouble(), value);
      });

      // Создаем данные для графика из точек
      LineChartBarData lineData = LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots,
        // другие настройки для LineChartBarData...
      );

      // Возвращаем список с одной линией данных
      return [lineData];
    }

    Future<int> getLineSymptomsNamesCount() async {
      final List<String> tmp =
          await service.database.symptomsNamesDao.getSymptomsNamesByTypeID(5);
      return tmp.length;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 360),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
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
            const SizedBox(height: 15),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250, maxWidth: 360),
              child: FutureBuilder(
                future: getLineData(pickedDate),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<List<double>> rawData = snapshot.data!;
                    final List<LineChartBarData> lineData = groupData(rawData);
                    return LineChart(
                      LineChartData(
                        // show border around BarChart
                        borderData: FlBorderData(show: false),

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
                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitlesWidget,
                              reservedSize: 50,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                for (int i = 0;
                                    i < symptomsMaxValues[currentPointIndex];
                                    i++) {
                                  if (value == i * 5) {
                                    return Text(
                                      '${value.toInt()}',
                                      style: const TextStyle(fontSize: 14),
                                    );
                                  }
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_left),
                          onPressed: () {
                            currentPointIndex > 0
                                ? currentPointIndex--
                                : currentPointIndex = totalPoints - 1;
                            setState(() {});
                          },
                          iconSize: 40,
                        ),
                        Wrap(
                          children: _buildPoints(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            currentPointIndex < totalPoints - 1
                                ? currentPointIndex++
                                : currentPointIndex = 0;
                            setState(() {});
                          },
                          iconSize: 40,
                        ),
                      ],
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
