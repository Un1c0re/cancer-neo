import 'dart:io';

import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/utils/pdf_generator.dart';
import 'package:diplom/views/widgets/charts/bool_chart_widget.dart';
import 'package:diplom/views/widgets/charts/custom_chart_widget.dart';
import 'package:diplom/views/widgets/charts/grade_chart_widget.dart';
import 'package:diplom/views/widgets/charts/line_chart_widget.dart';
import 'package:diplom/views/widgets/charts/marker_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomeChartsWidget extends StatefulWidget {
  final String appBarTitle;

  const HomeChartsWidget({super.key, required this.appBarTitle});
  @override
  State<HomeChartsWidget> createState() => _HomeChartsWidgetState();
}

class _HomeChartsWidgetState extends State<HomeChartsWidget> {
  DateTime _selectedDate = DateTime.now();

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

  void _incrementDate() {
    if (_selectedDate
        .isBefore(DateTime(DateTime.now().year, DateTime.now().month, 1))) {
      setState(() {
        _selectedDate = DateTime(
            _selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
      });
    }
  }

  void _decrementDate() {
    setState(() {
      _selectedDate = DateTime(
          _selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
    });
  }

  Future<void> uploadFile(String url, String filePath) async {
    // Создаем объект файла
    var file = File(filePath);

    // Создаем POST запрос
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Добавляем файл как часть многокомпонентного запроса
    request.files.add(await http.MultipartFile.fromPath(
      'file', // ключ, по которому сервер принимает файл
      filePath,
    ));

    // Можно добавить другие поля в запрос
    request.fields['user'] = 'Flutter';

    try {
      // Отправляем запрос
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Файл успешно отправлен');
      } else {
        print('Ошибка при отправке файла: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при отправке: $e');
    }
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
                width: 200,
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
                LineChartWidget(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                const Text(
                  'Маркеры',
                  style: TextStyle(fontSize: 22, color: AppColors.activeColor),
                ),
                const SizedBox(height: 5),
                MarkerChartWidget(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                CustomChartWidget(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: AppButtonStyle.basicButton.copyWith(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  ),
                  onPressed: () => generatePdfWithTable(_selectedDate),
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