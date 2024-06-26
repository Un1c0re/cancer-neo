import 'package:flutter/material.dart';
import 'package:get/get.dart';

void cancelAction() => Get.back();

void submitAction(title) {
  Get.back();
  Get.snackbar(
    'Успешно!',
    title,
    backgroundColor: Colors.tealAccent.withOpacity(0.4),
    colorText: Colors.teal.shade900,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(milliseconds: 1500),
    animationDuration: const Duration(milliseconds: 500),
  );
}

void editAction(title) {
  Get.back();
  Get.snackbar(
    'Успешно!',
    title,
    backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
    colorText: Colors.blue.shade900,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(milliseconds: 1500),
    animationDuration: const Duration(milliseconds: 500),
  );
}

void deleteAction(title) {
  Get.back();
  Get.snackbar(
    'Успешно!',
    title,
    backgroundColor: const Color.fromARGB(255, 255, 82, 111).withOpacity(0.4),
    colorText: const Color.fromARGB(255, 99, 31, 43),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(milliseconds: 1500),
    animationDuration: const Duration(milliseconds: 500),
  );
}

void errorAction(title) {
  Get.back();
  Get.snackbar(
    'Ошибка',
    title,
    backgroundColor: const Color.fromARGB(255, 255, 180, 82).withOpacity(0.4),
    colorText: const Color.fromARGB(255, 99, 50, 31),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(milliseconds: 1500),
    animationDuration: const Duration(milliseconds: 500),
  );
}
