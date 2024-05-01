import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

Future<DateTime?> selectDate(BuildContext context, DateTime pickedDate) async {
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
    return picked;
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
