import 'package:cancerneo/helpers/datetime_helpers.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Имя не может быть пустым';
  }

  final RegExp nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ ]+$');

  if (!nameRegExp.hasMatch(value)) {
    return 'Имя должно содержать только буквы и пробелы';
  }

  return null;
}

String? validateString(String? value) {
  if (value == null || value.isEmpty) {
    return 'Поле не может быть пустым';
  }
  
  return null;
}


String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Дата не может быть пустой';
  }

  // Проверка формата даты
  final RegExp dateRegExp = RegExp(r'^\d{2}-\d{2}-\d{4}$');
  if (!dateRegExp.hasMatch(value)) {
    return 'Дата должна быть в формате ГГГГ-ММ-ДД';
  }

  // Преобразование строки в дату
  DateTime? inputDate = customFormat.parse(value);
  // if (inputDate != null) {
  //   return 'Неверный формат даты';
  // }

  // Проверка, что дата не позднее текущей даты
  if (inputDate.isAfter(DateTime.now())) {
    return 'Дата не может быть позднее текущей даты';
  }

  return null;
}
