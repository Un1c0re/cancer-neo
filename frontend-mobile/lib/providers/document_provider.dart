import 'package:flutter/material.dart';

import '../models/document.dart';

class DocumentFilterProvider extends ChangeNotifier {
  DateTime? filterDate;
  List<Document> allDocuments = []; // Предположим, это ваш исходный список
  List<Document> get filteredDocuments => filterDate == null
      ? allDocuments
      : allDocuments.where((doc) => doc.date.isAfter(filterDate!)).toList();

  void setFilterDate(DateTime? date) {
    filterDate = date;
    notifyListeners(); // Это уведомит слушателей об изменении
  }

  // Добавьте методы для управления документами, если необходимо
}
