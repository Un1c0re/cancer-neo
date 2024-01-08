import 'package:get/get.dart';

class AuthController extends GetxController {
  bool isUserLoggedIn = true;

  void logout() {
    // Ваш код для выхода из аккаунта
    isUserLoggedIn = false;
  }
}