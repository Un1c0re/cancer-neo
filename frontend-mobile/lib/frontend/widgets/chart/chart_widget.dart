import 'dart:math';

import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:diplom/frontend/widgets/chart/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../Theme/app_style.dart';
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
      date = DateTime.now()
          .subtract(const Duration(days: 30))
          .toString()
          .substring(8, 10);
      break;
    case 7:
      date = DateTime.now()
          .subtract(const Duration(days: 23))
          .toString()
          .substring(8, 10);
      break;
    case 14:
      date = DateTime.now()
          .subtract(const Duration(days: 16))
          .toString()
          .substring(8, 10);
      break;
    case 21:
      date = DateTime.now()
          .subtract(const Duration(days: 9))
          .toString()
          .substring(8, 10);
      break;
    case 28:
      date = DateTime.now()
          .subtract(const Duration(days: 2))
          .toString()
          .substring(8, 10);
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

      cancelWidget: const Text('Отмена', 
        style: TextStyle(
          color: AppColors.activeColor,
          ),
        ),
      confirmWidget: const Text('Ок', 
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

    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 150,
            maxHeight: 50,
          ),
          child: OutlinedButton(
            style: AppButtonStyle.dateButton,
            onPressed: () => _selectMonthYear(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Симптомы со степенью проявления',
              style: TextStyle(
                color: AppColors.activeColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            GradeChart(),
          ],
        ),
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Симптомы с наличием или отсутствием',
              style: TextStyle(
                color: AppColors.activeColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            BoolChart(),
          ],
        ),
        SizedBox(height: 25),
        ElevatedButton(
          style: AppButtonStyle.filledRoundedButton,
          onPressed: () {},
          child: const Text('Экспорт отчета за месяц'),
        ),
      ]),
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

class BoolChart extends StatelessWidget {
  const BoolChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 150,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
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
                    getTitlesWidget: boolChartleftTitles,
                    reservedSize: 100,
                  ),
                ),
              ),

              // bars values
              barGroups: generateBoolData()),
        ),
      ),
    );
  }
}
