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

Widget leftTitles(double value, TitleMeta meta) {
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

BarChartGroupData generateGroupData(
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
          toY:    12 + symptome3,
          color: ColorTween(
            begin: AppColors.barColor,
            end: AppColors.barShadow,
          ).evaluate(AlwaysStoppedAnimation(symptome4 / 4)),
          width: 8,
        ),
      ],
    );
  }


///////////////////////////////////////////////////////////////////////////////


class _ChartWidgetState extends State<ChartWidget> {
  List<double> stats = [0, 1, 0, 2, 2, 1, 0];


  @override
  Widget build(BuildContext context) {

      SymptomeBarData symptomeList = SymptomeBarData();
      symptomeList.initializeData();

    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
          style: AppButtonStyle.filledRoundedButton,
          onPressed: () {},
          child: const Text('Экспорт отчета за месяц'),
        ),
        GradeChart(),
      ]),
    );
  }
}

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
            gridData: FlGridData(
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
                  getTitlesWidget: leftTitles,
                  reservedSize: 100,
                ),
              ),
            ),
            
            // bars values
            barGroups: [
              generateGroupData(0, 1, 2, 1, 2),
              generateGroupData(1, 2, 1, 2, 3),
              generateGroupData(2, 1, 1, 2, 2),
              generateGroupData(3, 2, 1, 1, 1),
              generateGroupData(4, 3, 2, 2, 0),
              generateGroupData(5, 1, 2, 3, 2),
              generateGroupData(6, 0, 1, 2, 3),
            ],
          ),
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////////////////////

// class ChartCard extends StatelessWidget {
//   final bool isBoolean;
//   final String chartName;
//   final List<double> chartValues;
//   const ChartCard({
//     super.key,
//     required this.chartName,
//     required this.isBoolean,
//     required this.chartValues,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: AppStyleCard(
//         backgroundColor: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               chartName,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(
//                 height: 150,
//                 child: isBoolean
//                     ? WeeklyBooleanBarChart(data: chartValues)
//                     : WeeklyBarChart(chartValues)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WeeklyBooleanBarChart extends StatelessWidget {
//   final List<double> data;
//   const WeeklyBooleanBarChart({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: 1,
//         barTouchData: BarTouchData(enabled: false),
//         titlesData: const FlTitlesData(
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: bottomTitles,
//               reservedSize: 25,
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: leftBooleanTitles,
//               reservedSize: 55,
//             ),
//           ),
//         ),
//         borderData: FlBorderData(show: false),
//         barGroups: data
//             .asMap()
//             .entries
//             .map((entry) => BarChartGroupData(x: entry.key, barRods: [
//                   BarChartRodData(toY: entry.value, color: Colors.blue)
//                 ]))
//             .toList(),
//       ),
//     );
//   }
// }

// class WeeklyBarChart extends StatelessWidget {
//   final List<double> data;

//   const WeeklyBarChart(this.data, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: 3,
//         barTouchData: BarTouchData(enabled: false),
//         titlesData: const FlTitlesData(
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: bottomTitles,
//               reservedSize: 25,
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: leftTitles,
//               reservedSize: 55,
//             ),
//           ),
//         ),
//         borderData: FlBorderData(show: false),
//         barGroups: data
//             .asMap()
//             .entries
//             .map((entry) => BarChartGroupData(x: entry.key, barRods: [
//                   BarChartRodData(toY: entry.value, color: Colors.blue)
//                 ]))
//             .toList(),
//       ),
//     );
//   }
// }



// Widget leftBooleanTitles(double value, TitleMeta meta) {
//   const style = TextStyle(fontSize: 12);
//   String text;

//   switch (value) {
//     case 0:
//       text = 'Симптом';
//       break;
//     case 1:
//       text = 'Симптом';
//       break;
//     case 1:
//       text = 'Симптом';
//       break;
//     default:
//       text = ' ';
//       break;
//   }

//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: Text(
//       text,
//       style: style,
//     ),
//   );
// }
