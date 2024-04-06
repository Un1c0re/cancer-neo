import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/views/widgets/chart/bool_chart_widget.dart';
import 'package:diplom/views/widgets/chart/grade_chart_widget.dart';
import 'package:diplom/views/widgets/chart/line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
import 'package:intl/intl.dart';


class ChartWidget extends StatefulWidget {
  final Color leftBarColor = AppColors.activeColor;
  final Color rightBarColor = AppColors.redColor;

  const ChartWidget({super.key});
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 10),
                GradeChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                BoolChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                MyLineChart(),
                const SizedBox(height: 25),
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
                const SizedBox(height: 10),
              ]),
        ),
      ),
    );
  }
}