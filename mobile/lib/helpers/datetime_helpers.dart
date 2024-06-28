import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

DateFormat customFormat = DateFormat('dd-MM-yyyy');

DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getFirstDayOfNextMonth(DateTime date) {
  if (date.month == 12) {
    return DateTime(date.year + 1, 1, 1);
  } else {
    return DateTime(date.year, date.month + 1, 1);
  }
}
DateTime getLastDayOfMonth(DateTime date) {
  // Получаем следующий месяц
  int nextMonth = date.month == 12 ? 1 : date.month + 1;
  int nextYear = date.month == 12 ? date.year + 1 : date.year;

  // Устанавливаем день в 0, чтобы получить последний день предыдущего месяца
  return DateTime(nextYear, nextMonth, 0);
}

Future<DateTime?> selectDate(BuildContext context, DateTime pickedDate, Function updateParentState) async {
  final DateTime? picked = await showDatePicker(
    locale: const Locale('ru', 'RU'),
    context: context,
    initialDate: pickedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    cancelText: 'Сбросить',
    confirmText: 'Подтвердить',
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primaryColor,
          colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
  if (picked != null && picked != pickedDate) {
    updateParentState(picked);
  }
  return null;
}

String getMonthNameNominative(DateTime date) {
  // Словарь для преобразования месяца из родительного в именительный падеж
  const monthNames = {
    'янв.': 'Январь',
    'фев.': 'Февраль',
    'мар.': 'Март',
    'апр.': 'Апрель',
    'мая': 'Май',
    'июн.': 'Июнь',
    'июл.': 'Июль',
    'авг.': 'Август',
    'сен.': 'Сентябрь',
    'окт.': 'Октябрь',
    'ноя.': 'Ноябрь',
    'дек.': 'Декабрь'
  };

  // Форматируем дату в родительном падеже
  String monthPart =
      DateFormat('MMM', const Locale('ru', 'RU').toString()).format(date);

  // Преобразуем в именительный падеж, если возможно
  return monthNames[monthPart] ?? monthPart;
}

Future selectDateRange(
  BuildContext context,
  DateRangePickerController controller,
  Function updateState,
) {
  return showDialog<DateRangePickerController>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color.fromRGBO(238, 243, 249, 1),
          surfaceTintColor: const Color.fromRGBO(238, 243, 249, 1),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: DeviceScreenConstants.screenHeight * 0.6,
            width: DeviceScreenConstants.screenWidth * 0.9,
            child: Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColors.primaryColor, // Цвет выбранной даты
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor, // Цветовая схема
                  onPrimary: Colors.white, // Цвет текста на выбранной дате
                  surface: Colors.white, // Цвет фона элементов
                  onSurface: Colors.black, // Цвет текста элементов
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        AppColors.activeColor, // Цвет текста кнопок
                  ),
                ),
              ),
              child: SfDateRangePicker(
                  maxDate: DateTime.now(),
                  selectionColor: AppColors.primaryColor,
                  startRangeSelectionColor: AppColors.primaryColor,
                  endRangeSelectionColor: AppColors.primaryColor,
                  confirmText: 'Подтвердить',
                  cancelText: 'Сбросить',
                  view: DateRangePickerView.month,
                  controller: controller,
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () {
                    controller.selectedRange = null;
                    updateState();
                    Get.back();
                  },
                  onSubmit: (Object? args) {
                    if (args is PickerDateRange) {
                      updateState();
                    }
                    Get.back();
                  }),
            ),
          ),
        );
      });
}
