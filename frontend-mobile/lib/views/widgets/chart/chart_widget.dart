import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/views/widgets/chart/bool_chart_widget.dart';
import 'package:diplom/views/widgets/chart/grade_chart_widget.dart';
import 'package:diplom/views/widgets/chart/line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
// ignore: depend_on_referenced_packages
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

  // Future<void> _selectMonthYear(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     locale: const Locale('ru', 'RU'),
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2025),
  //     cancelText: 'Отменить',
  //     confirmText: 'Подтвердить',
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           primaryColor: AppColors.primaryColor, // Цвет выбранной даты
  //           colorScheme: ColorScheme.light(
  //             primary: AppColors.primaryColor, // Цветовая схема
  //           ),
  //           buttonTheme: ButtonThemeData(
  //             textTheme: ButtonTextTheme.primary, // Тема кнопок
  //           ),
  //           // Другие параметры темы, если они вам нужны
  //         ),
  //         child: child!,
  //       );
  //     },
  //     // Эти параметры уберут выбор дня:
  //     selectableDayPredicate: (DateTime date) {
  //       // Разрешить выбор только первого дня каждого месяца
  //       return date.day == 1;
  //     },
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     // Обновите _selectedDate только с годом и месяцем
  //     setState(() {
  //       _selectedDate = DateTime(picked.year, picked.month);
  //     });
  //   }
  // }

  Future<void> _selectMonthYear(BuildContext context) async {
    return showMonthPicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: _selectedDate,
      customHeight: 300,
      customWidth: 330,
      headerColor: Color.fromRGBO(238, 243, 249, 1),
      headerTextColor: Colors.black,
      unselectedMonthTextColor: Colors.black,
      selectedMonthBackgroundColor: AppColors.primaryColor,
      backgroundColor: Color.fromRGBO(238, 243, 249, 1),
      roundedCornersRadius: 30,
      dismissible: true,
      animationMilliseconds: 300,
      cancelWidget: const Text(
        'Отмена',
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

  // void _incrementMonth() {
  //   setState(() {
  //     _selectedDate = DateTime(
  //         _selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
  //   });
  // }

  // void _decrementMonth() {
  //   setState(() {
  //     _selectedDate = DateTime(
  //         _selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMM(const Locale('ru', 'RU').toString())
        .format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
              foregroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
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
                LineChartWidget(selectedDate: _selectedDate),
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
