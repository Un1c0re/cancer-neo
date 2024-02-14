import 'dart:math';

import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/widgets/chart/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
import 'package:intl/intl.dart';

///////////////////////////////////////////////////////////////////////////////

Widget gradeChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 18);
  String text;

  switch (value) {
    case 0:
      text = 'Симптом';
      break;
    case 5:
      text = 'Симптом';
      break;
    case 10:
      text = 'Симптом';
    case 15:
      text = 'Симптом';
      break;
    default:
      // text = '${value}';
      text = '';
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      text,
      style: style,
    ),
  );
}

Widget boolChartleftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 18);

  String text;

  switch (value) {
    case 0:
      text = 'Симптом';
      break;
    case 4:
      text = 'Симптом';
      break;
    default:
      text = ' ';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      text,
      style: style,
    ),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
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

///////////////////////////////////////////////////////////////////////////////

BarChartGroupData gradeChartGroupData(
  int x,
  double symptome1,
  double symptome2,
  double symptome3,
  double symptome4,
) {
  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: symptome1,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome1 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 4,
        toY: 4 + symptome2,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome2 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 8,
        toY: 8 + symptome3,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome3 / 4)),
        width: 8,
      ),
      BarChartRodData(
        fromY: 12,
        toY: 12 + symptome4,
        color: ColorTween(
          begin: AppColors.barColor,
          end: AppColors.barShadow,
        ).evaluate(AlwaysStoppedAnimation(symptome4 / 4)),
        width: 8,
      ),
    ],
  );
}

BarChartGroupData boolChartGroupData(
  int x,
  int symptome1,
  int symptome2,
) {
  bool value1 = symptome1 != 0;
  bool value2 = symptome2 != 0;

  return BarChartGroupData(
    x: x,
    groupVertically: true,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: 0.5,
        borderSide: const BorderSide(
          color: AppColors.activeColor,
          style: BorderStyle.solid,
        ),
        color: value1 ? AppColors.activeColor : Colors.transparent,
        width: 8,
      ),
      BarChartRodData(
        fromY: 4,
        toY: 4.5,
        borderSide: const BorderSide(
          color: AppColors.activeColor,
          style: BorderStyle.solid,
        ),
        color: value2 ? AppColors.activeColor : Colors.transparent,
        width: 8,
      ),
    ],
  );
}

List<BarChartGroupData> generateGradeData() {
  List<BarChartGroupData> groupDataList = [];
  for (int i = 0; i < 30; i++) {
    groupDataList.add(gradeChartGroupData(
        i,
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble(),
        Random().nextInt(4).toDouble()));
  }
  return groupDataList;
}

List<BarChartGroupData> generateBoolData() {
  List<BarChartGroupData> groupDataList = [];
  for (int i = 0; i < 30; i++) {
    groupDataList
        .add(boolChartGroupData(i, Random().nextInt(2), Random().nextInt(2)));
  }
  return groupDataList;
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class ChartWidget extends StatefulWidget {
  final Color leftBarColor = AppColors.activeColor;
  final Color rightBarColor = AppColors.redColor;

  const ChartWidget({super.key});
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class WeekData {
  final List<double> dataValues;
  final String dataName;
  final bool isBoolean;

  WeekData({
    required this.isBoolean,
    required this.dataValues,
    required this.dataName,
  });
}

class _ChartWidgetState extends State<ChartWidget> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectMonthYear(BuildContext context) async {
    return showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      headerColor: AppColors.primaryColor,
      selectedMonthBackgroundColor: AppColors.activeColor,
      unselectedMonthTextColor: AppColors.activeColor,
      roundedCornersRadius: 10,
      dismissible: true,
      animationMilliseconds: 300,
      cancelWidget: const Text(
        'Отмена',
        style: TextStyle(
          color: AppColors.activeColor,
        ),
      ),
      confirmWidget: const Text(
        'Ок',
        style: TextStyle(
          color: AppColors.activeColor,
        ),
      ),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void _incrementMonth() {
    setState(() {
      _selectedDate = DateTime(
          _selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
    });
  }

  void _decrementMonth() {
    setState(() {
      _selectedDate = DateTime(
          _selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMM().format(_selectedDate);
    SymptomeBarData symptomeList = SymptomeBarData();
    symptomeList.initializeData();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
              foregroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(255, 255, 255, 255)),
            ),
            onPressed: () => _selectMonthYear(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.calendar_today_outlined),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradeChart(),
                SizedBox(height: 30),
                BoolChart(),
                SizedBox(height: 30),
                _LineChart(),
                SizedBox(height: 25),
                ElevatedButton(
                  style: AppButtonStyle.basicButton.copyWith(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Экспорт отчета за месяц',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////

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
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          isPointerIncremented = false;
          isPointerDecremented = false;
        },
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < 0) {
            isPointerDecremented = false;
            setState(() {
              if (pointCounter < 7 && !isPointerIncremented) {
                pointCounter += 1;
                isPointerIncremented = true;
                updateColors();
              }
            });
          } else if (details.primaryDelta! > 0) {
            setState(() {
              isPointerIncremented = false;
              if (pointCounter > 0 && !isPointerDecremented) {
                isPointerDecremented = true;
                pointCounter -= 1;
                updateColors();
              }
            });
          }
        },
        child: AppStyleCard(
          backgroundColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(8, (index) {
                  return CircleAvatar(
                      radius: 6.0, backgroundColor: colors[index]);
                }),
              ),
              ConstrainedBox(
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
                            reservedSize: 80,
                          ),
                        ),
                      ),

                      // bars values
                      barGroups: generateBoolData()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _LineChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: LineChart(
          sampleData2,
          duration: const Duration(milliseconds: 250),
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
    return _LineChart();
  }
}