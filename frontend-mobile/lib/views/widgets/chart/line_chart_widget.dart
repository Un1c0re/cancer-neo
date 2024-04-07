import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/datetime_helpers.dart';
import 'package:diplom/views/widgets/chart/chart_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LineChartWidget extends StatefulWidget {
  final DateTime selectedDate;
  const LineChartWidget({super.key, required this.selectedDate});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late int totalPoints;
  int currentPointIndex = 0;
  List<String> symptomNames = [];

  Future<void> loadSymptomNames() async {
    final names = await Get.find<DatabaseService>()
        .database
        .symptomsNamesDao
        .getSymptomsNamesByTypeID(3);
    setState(() {
      symptomNames = names;
      totalPoints = names.length;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSymptomNames();
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
            width: 100 / totalPoints, // Ширина точки
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
    final DatabaseService service = Get.find();
    final pickedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    Future<List<List<double>>> getLineData(DateTime date) async {
      final monthStart = getFirstDayOfMonth(date);
      final monthEnd = getFirstDayOfNextMonth(date);

      List<List<double>> rawDataList = await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(3, monthStart, monthEnd);

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
          await service.database.symptomsNamesDao.getSymptomsNamesByTypeID(3);
      return tmp.length;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 450),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
             symptomNames.isNotEmpty ? symptomNames[currentPointIndex] : 'Загрузка...',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
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
                          horizontalInterval: 4,
                          drawVerticalLine: true,
                          verticalInterval: 5,
                        ),
                        titlesData: const FlTitlesData(
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitlesWidget,
                              reservedSize: 25,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: lineChartleftTitles,
                              reservedSize: 100,
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
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
