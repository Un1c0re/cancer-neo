import 'package:diplom/backend/repositories/auth_repository.dart';
import 'package:diplom/frontend/screens/home/home_screen.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthRepository.instance.verifyOTP(otp);

    isVerified
    ? Get.offAll(() => const HomeScreen())
    : Get.snackbar('Ошибка', 'Неверный код. Попробуйте еще раз');
  }
}