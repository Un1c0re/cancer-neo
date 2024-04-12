import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/widgets/chart/bool_chart_widget.dart';
import 'package:diplom/views/widgets/chart/custom_chart_widget.dart';
import 'package:diplom/views/widgets/chart/grade_chart_widget.dart';
import 'package:diplom/views/widgets/chart/line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../utils/app_style.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMM(const Locale('ru', 'RU').toString())
        .format(_selectedDate);
    formattedDate = formattedDate.substring(0, formattedDate.length - 2);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.appBarTitle,
                style: const TextStyle(fontSize: 26),
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
                  style: const TextStyle(fontSize: 20),
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
                GradeChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                BoolChart(selectedDate: _selectedDate),
                const SizedBox(height: 30),
                LineChartWidget(selectedDate: _selectedDate),
                const SizedBox(height: 25),
                CustomChartWidget(selectedDate: _selectedDate),
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
