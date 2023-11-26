import 'package:get/get.dart';

import '../../frontend/screens/home/home_screen.dart';
import '../repositories/auth_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthRepository.instance.verifyOTP(otp);

    isVerified
    ? Get.offAll(() => const HomeScreen())
    : Get.snackbar('Ошибка', 'Неверный код. Попробуйте еще раз');
  }
}