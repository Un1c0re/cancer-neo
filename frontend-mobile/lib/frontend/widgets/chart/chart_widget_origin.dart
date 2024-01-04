import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:diplom/frontend/widgets/chart/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../Theme/app_style.dart';


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

///////////////////////////////////////////////////////////////////////////////

Widget GradeChartleftTitles(double value, TitleMeta meta) {
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

Widget BoolChartleftTitles(double value, TitleMeta meta) {
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
          .subtract(const Duration(days: 6))
          .toString()
          .substring(8, 10);
      break;
    case 1:
      date = DateTime.now()
          .subtract(const Duration(days: 5))
          .toString()
          .substring(8, 10);
      break;
    case 2:
      date = DateTime.now()
          .subtract(const Duration(days: 4))
          .toString()
          .substring(8, 10);
      break;
    case 3:
      date = DateTime.now()
          .subtract(const Duration(days: 3))
          .toString()
          .substring(8, 10);
      break;
    case 4:
      date = DateTime.now()
          .subtract(const Duration(days: 2))
          .toString()
          .substring(8, 10);
      break;
    case 5:
      date = DateTime.now()
          .subtract(const Duration(days: 1))
          .toString()
          .substring(8, 10);
      break;
    case 6:
      date = DateTime.now().day.toString();
      break;
    default:
      date = '0';
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
          fromY:  4,
          toY:    4 + symptome2,
          color: ColorTween(
            begin: AppColors.barColor,
            end: AppColors.barShadow,
          ).evaluate(AlwaysStoppedAnimation(symptome2 / 4)),
          width: 8,
        ),
        BarChartRodData(
          fromY:  8,
          toY:    8 + symptome3,
          color: ColorTween(
            begin: AppColors.barColor,
            end: AppColors.barShadow,
          ).evaluate(AlwaysStoppedAnimation(symptome3 / 4)),
          width: 8,
        ),
        BarChartRodData(
          fromY:  12,
          toY:    12 + symptome4,
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
          toY: 1,
          borderSide: const BorderSide(
            color: AppColors.activeColor,
            style: BorderStyle.solid,
          ),
          color:  value1 
                    ? AppColors.activeColor 
                    : Colors.transparent, 
          width: 8,
        ),
        BarChartRodData(
          fromY:  4,
          toY:    5,

          borderSide: const BorderSide(
            color: AppColors.activeColor,
            style: BorderStyle.solid,
          ),
          color:  value2 
                    ? AppColors.activeColor 
                    : Colors.transparent,
          width: 8,
        ),
      ],
    );
  }


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


class _ChartWidgetState extends State<ChartWidget> {

  @override
  Widget build(BuildContext context) {

      SymptomeBarData symptomeList = SymptomeBarData();
      symptomeList.initializeData();

    return SingleChildScrollView(
      child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Симптомы со степенью проявления', 
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
                Text('Симптомы с наличием или отсутствием', 
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
              verticalInterval: 0.145,
            ),


            // Titles
            titlesData: const FlTitlesData(
              topTitles:    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              
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
                  getTitlesWidget: GradeChartleftTitles,
                  reservedSize: 100,
                ),
              ),
            ),
            
            // bars values
            barGroups: [
              gradeChartGroupData(0, 1, 2, 1, 2),
              gradeChartGroupData(1, 2, 1, 2, 3),
              gradeChartGroupData(2, 1, 1, 2, 2),
              gradeChartGroupData(3, 2, 1, 1, 1),
              gradeChartGroupData(4, 3, 2, 2, 0),
              gradeChartGroupData(5, 1, 2, 3, 2),
              gradeChartGroupData(6, 0, 1, 2, 3),
            ],
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
              verticalInterval: 0.145,
            ),


            // Titles
            titlesData: const FlTitlesData(
              topTitles:    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              
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
                  getTitlesWidget: BoolChartleftTitles,
                  reservedSize: 100,
                ),
              ),
            ),
            
            // bars values
            barGroups: [
              boolChartGroupData(0, 1, 1),
              boolChartGroupData(1, 0, 1),
              boolChartGroupData(2, 1, 0),
              boolChartGroupData(3, 1, 0),
              boolChartGroupData(4, 0, 1),
              boolChartGroupData(5, 1, 1),
              boolChartGroupData(6, 0, 0),
            ],
          ),
        ),
      ),
    );
  }
}