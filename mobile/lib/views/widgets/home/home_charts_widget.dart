import 'package:cancerneo/helpers/loading_dialog_helpers.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/utils/pdf_generator.dart';
import 'package:cancerneo/views/widgets/charts/bool_chart_widget.dart';
import 'package:cancerneo/views/widgets/charts/grade_chart_widget.dart';
import 'package:cancerneo/views/widgets/charts/line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
import 'package:intl/intl.dart';

class HomeChartsWidget extends StatefulWidget {
  final String appBarTitle;

  const HomeChartsWidget({super.key, required this.appBarTitle});
  @override
  State<HomeChartsWidget> createState() => _HomeChartsWidgetState();
}

class _HomeChartsWidgetState extends State<HomeChartsWidget> {
  DateTime _selectedDate = DateTime.now();

  // Окно выбора месяца для отображения данных
  Future<void> _selectMonthYear(BuildContext context) async {
    return showMonthPicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      lastDate: DateTime.now(),
      initialDate: _selectedDate,
      customHeight: 300,
      customWidth: DeviceScreenConstants.screenWidth * 0.9,
      headerColor: const Color.fromRGBO(238, 243, 249, 1),
      headerTextColor: Colors.black,
      unselectedMonthTextColor: Colors.black,
      selectedMonthBackgroundColor: AppColors.primaryColor,
      backgroundColor: const Color.fromRGBO(238, 243, 249, 1),
      roundedCornersRadius: 30,
      dismissible: true,
      animationMilliseconds: 300,
      cancelWidget: const Text(
        'Сбросить',
        style: TextStyle(
          color: AppColors.primaryColor,
        ),
      ),
      confirmWidget: const Text(
        'Подтвердить',
        style: TextStyle(
          color: AppColors.primaryColor,
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

  // Для передачи в другие виджеты
  void onUpdate() {
    setState(() {});
  }

  // Верхнее меню: выбрать следующий месяц.
  // Нельзя выбрать дальше, чем текущий месяц
  void _incrementDate() {
    if (_selectedDate
        .isBefore(DateTime(DateTime.now().year, DateTime.now().month, 1))) {
      setState(() {
        _selectedDate = DateTime(
            _selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
      });
    }
  }

  // Верхнее меню: выбрать предыдущий месяц.
  void _decrementDate() {
    setState(() {
      _selectedDate = DateTime(
          _selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MMM y', const Locale('ru', 'RU').toString())
            .format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: DeviceScreenConstants.screenWidth * 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.appBarTitle,
                style: const TextStyle(fontSize: 26),
              ),
              SizedBox(
                width: 190,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _decrementDate,
                      icon: const Icon(Icons.keyboard_arrow_left),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () => _selectMonthYear(context),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementDate,
                      icon: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ],
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
                const Text(
                  'Условные параметры',
                  style: TextStyle(fontSize: 22, color: AppColors.activeColor),
                ),
                const SizedBox(height: 5),
                GradeChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                const Text(
                  'Двухуровневые параметры',
                  style: TextStyle(fontSize: 22, color: AppColors.activeColor),
                ),
                const SizedBox(height: 5),
                BoolChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                const Text(
                  'Численные параметры',
                  style: TextStyle(fontSize: 22, color: AppColors.activeColor),
                ),
                const SizedBox(height: 5),
                LineChartWidget(
                  selectedDate: _selectedDate,
                  lineColor: AppColors.primaryColor,
                  typeID: 3,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Маркеры',
                  style: TextStyle(fontSize: 22, color: AppColors.activeColor),
                ),
                const SizedBox(height: 5),
                LineChartWidget(
                  selectedDate: _selectedDate,
                  lineColor: AppColors.redColor,
                  typeID: 4,
                ),
                const SizedBox(height: 30),
                LineChartWidget(
                  selectedDate: _selectedDate,
                  lineColor: AppColors.activeColor,
                  typeID: 5,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: AppButtonStyle.basicButton.copyWith(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  ),
                  onPressed: () => showDateRangePickerDialog(
                    context,
                    generatePDF,
                  ),
                  child: const Text(
                    'Экспорт отчета',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
        ),
      ),
    );
  }
}
