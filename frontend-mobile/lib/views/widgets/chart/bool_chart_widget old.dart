// import 'package:diplom/services/database_service.dart';
// import 'package:diplom/utils/app_colors.dart';
// import 'package:diplom/utils/app_widgets.dart';
// import 'package:diplom/utils/datetime_helpers.dart';
// import 'package:diplom/views/widgets/chart/bar_data.dart';
// import 'package:diplom/views/widgets/chart/chart_titles.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class BoolChart extends StatefulWidget {
//   final DateTime selectedDate;
//   const BoolChart({super.key, required this.selectedDate});

//   @override
//   State<BoolChart> createState() => _BoolChartState();
// }

// class _BoolChartState extends State<BoolChart> {
//   // Предположим, что у вас есть функция, которая обновляет данные графика
//   void _loadNextData() {
//     // Обновите ваш график данными за следующий период
//   }

//   void _loadPreviousData() {
//     // Обновите ваш график данными за предыдущий период
//   }

//   // Предположим, что это количество всех точек
//   late int totalPoints;
//   // А это индекс текущей выбранной точки
//   int currentPointIndex = 0;

//   List<Widget> _buildPoints() {
//     List<Widget> points = [];
//     for (int i = 0; i < totalPoints; i++) {
//       points.add(
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               currentPointIndex = i;
//               // Тут можно вызвать функцию, которая обновит данные
//             });
//           },
//           child: Container(
//             width: 100 / totalPoints, // Ширина точки
//             height: 5, // Высота точки
//             margin:
//                 EdgeInsets.symmetric(horizontal: 2), // Расстояние между точками
//             decoration: BoxDecoration(
//               color: i == currentPointIndex
//                   ? AppColors.activeColor
//                   : AppColors.backgroundColor,
//               // shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       );
//     }
//     return points;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DatabaseService service = Get.find();
//     final pickedDate = DateTime(widget.selectedDate.year,
//         widget.selectedDate.month, widget.selectedDate.day);

//     Future<int> getBoolSymptomsNamesCount() async {
//       final List<String> tmp =
//           await service.database.symptomsNamesDao.getSymptomsNamesByTypeID(1);
//       return tmp.length;
//     }

//     Future<List<BarChartGroupData>> getBoolData(DateTime date) async {
//       final monthStart = getFirstDayOfMonth(date);
//       final monthEnd = getFirstDayOfNextMonth(date);

//       List<List<double>> rawDataList = await service.database.symptomsValuesDao
//           .getSymptomsSortedByDayAndNameID(1, monthStart, monthEnd);

//       // Убедимся, что endIndex не выходит за пределы списка
//       int startIndex = currentPointIndex * 2;

//       // Получаем срез списка для текущей выбранной точки
//       List<List<double>> filteredDataList = rawDataList.map((dayList) {
//         int endIndex = startIndex + 2;
//         endIndex = endIndex < dayList.length ? endIndex : dayList.length;
//         return dayList.sublist(currentPointIndex, endIndex);
//       }).toList();

//       List<BarChartGroupData> groupDataList = [];
//       for (int i = 0; i < filteredDataList.length; i++) {
//         groupDataList.add(boolChartGroupData(i, filteredDataList[i]));
//       }

//       return groupDataList;
//     }

//     return ConstrainedBox(
//       constraints: const BoxConstraints(
//         maxHeight: 220,
//       ),
//       child: AppStyleCard(
//         backgroundColor: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxHeight: 150,
//               ),
//               child: FutureBuilder<List<BarChartGroupData>>(
//                 future: getBoolData(pickedDate),
//                 builder: ((context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     final List<BarChartGroupData> barData = snapshot.data!;
//                     return BarChart(
//                       BarChartData(
//                         alignment: BarChartAlignment.spaceAround,
//                         maxY: 8,

//                         // showing value while touching bar
//                         barTouchData: BarTouchData(enabled: false),
//                         // show border around BarChart
//                         borderData: FlBorderData(show: false),

//                         // grid
//                         gridData: const FlGridData(
//                           horizontalInterval: 4,
//                           verticalInterval: 0.2356,
//                         ),

//                         // Titles
//                         titlesData: const FlTitlesData(
//                           topTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false)),
//                           rightTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false)),
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: bottomTitles,
//                               reservedSize: 25,
//                             ),
//                           ),
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: boolChartleftTitles,
//                               reservedSize: 100,
//                             ),
//                           ),
//                         ),
//                         // bars values
//                         barGroups: barData.sublist(
//                             currentPointIndex, currentPointIndex + 2),
//                       ),
//                     );
//                   }
//                 }),
//               ),
//             ),
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: 45,
//               ),
//               child: FutureBuilder(
//                   future: getBoolSymptomsNamesCount(),
//                   builder: ((context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       totalPoints = snapshot.data! ~/ 2;
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.arrow_left),
//                             onPressed: _loadPreviousData,
//                             iconSize: 40,
//                           ),
//                           Wrap(
//                             children: _buildPoints(),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.arrow_right),
//                             onPressed: _loadNextData,
//                             iconSize: 40,
//                           ),
//                         ],
//                       );
//                     }
//                   })),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
