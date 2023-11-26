import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../frontend/screens/auth/auth_screen.dart';
import '../../frontend/screens/home/home_screen.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
      ? Get.offAll(() => const AuthScreen())
      : Get.offAll(() => const HomeScreen());
  }

  Future <void> phoneAuth(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      }, 
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Ошибка', 'Неправильный номер телефона');
        } else {
          Get.snackbar('Ошибка', 'Что-то пошло не так. Попробуйте еще раз');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value, 
          smsCode: otp,
        ),
      );
      return credentials.user != null? true : false;
    } catch (error) {
      Get.snackbar('Ошибка', 'неверный код. Попробуйте еще раз');
      return false;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}