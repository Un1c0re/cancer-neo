import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../Theme/app_style.dart';

class ChartWidget extends StatefulWidget {
  final Color leftBarColor = AppColors.activeColor;
  final Color rightBarColor = AppColors.favouriteColor;

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
  List<double> stats = [0, 1, 0, 2, 2, 1, 0];

  List<WeekData> weekData = [
    WeekData(
        dataValues: [0, 1, 0, 2, 2, 1, 0],
        dataName: 'Слабость, утомляемость',
        isBoolean: false),
    WeekData(
        dataValues: [1, 1, 2, 0, 3, 3, 1],
        dataName: 'Болевой синдром',
        isBoolean: false),
    WeekData(
        dataValues: [0, 1, 0, 1, 2, 1, 3],
        dataName: 'Депрессия, тревога',
        isBoolean: false),
    WeekData(
        dataValues: [2, 3, 1, 1, 1, 1, 0],
        dataName: 'Мигрень',
        isBoolean: false),
    WeekData(
        dataValues: [0, 1, 0, 1, 0, 0, 1], dataName: 'Рвота', isBoolean: true),
    WeekData(
        dataValues: [0, 1, 0, 1, 0, 0, 1],
        dataName: 'Уменьшение диуреза',
        isBoolean: true),
    WeekData(
        dataValues: [1, 1, 1, 0, 1, 1, 1],
        dataName: 'Ухудшение памяти',
        isBoolean: true),
    WeekData(
        dataValues: [0, 1, 0, 1, 1, 1, 0],
        dataName: 'Нарушение моторных функций',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0], dataName: 'Хрипы', isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Бронхоспазм',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Боль в левой части грудной клетки',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Аритмия',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Спутанность сознания (химический мозг)',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Спутанность сознания (прилив жара к верхней части туловища)',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Нейродермит (сыпь, зуд)',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Стоматит',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Невропатия руки',
        isBoolean: true),
    WeekData(
        dataValues: [1, 0, 0, 0, 0, 1, 0],
        dataName: 'Невропатия ноги',
        isBoolean: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
          style: AppButtonStyle.filledRoundedButton,
          onPressed: () {},
          child: Text('Экспорт отчета за месяц'),
        ),
        ...weekData.map((chartData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ChartCard(
                chartName: chartData.dataName,
                chartValues: chartData.dataValues,
                isBoolean: chartData.isBoolean),
          );
        }).toList()
      ]),
    );
  }
}

class ChartCard extends StatelessWidget {
  final bool isBoolean;
  final String chartName;
  final List<double> chartValues;
  const ChartCard({
    super.key,
    required this.chartName,
    required this.isBoolean,
    required this.chartValues,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              chartName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
                height: 150,
                child: isBoolean
                    ? WeeklyBooleanBarChart(data: chartValues)
                    : WeeklyBarChart(chartValues)),
          ],
        ),
      ),
    );
  }
}

class WeeklyBooleanBarChart extends StatelessWidget {
  final List<double> data;
  const WeeklyBooleanBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1,
        barTouchData: BarTouchData(enabled: false),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
              getTitlesWidget: leftBooleanTitles,
              reservedSize: 55,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: data
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                  BarChartRodData(toY: entry.value, color: Colors.blue)
                ]))
            .toList(),
      ),
    );
  }
}

class WeeklyBarChart extends StatelessWidget {
  final List<double> data;

  const WeeklyBarChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 3,
        barTouchData: BarTouchData(enabled: false),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
              reservedSize: 55,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: data
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                  BarChartRodData(toY: entry.value, color: Colors.blue)
                ]))
            .toList(),
      ),
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 12);
  String text;

  switch (value) {
    case 0:
      text = 'нет';
      break;
    case 1:
      text = 'слабо';
      break;
    case 2:
      text = 'средне';
    case 3:
      text = 'сильно';
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

Widget leftBooleanTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 12);
  String text;

  switch (value) {
    case 0:
      text = 'нет';
      break;
    case 1:
      text = 'Да';
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
  const style = TextStyle(fontSize: 12);
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
