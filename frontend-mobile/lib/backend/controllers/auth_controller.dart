import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

class AuthController extends GetxController {
  bool isUserLoggedIn = true;

  void logout() {
    // Ваш код для выхода из аккаунта
    isUserLoggedIn = false;
  }
}