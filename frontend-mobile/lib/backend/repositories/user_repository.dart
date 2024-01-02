import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  String uuid = '';

  Future<void> _saveUserId(String uuid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', uuid);
  }

  Future<void> saveUserData(String userdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userdata', userdata);
  }

  Future<String> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uuid') ?? '';
    return uuid;
  }

  Future<String> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userdata = prefs.getString('userdata') ?? '';
    return userdata;
  }

  void removeDataFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userdata');
  }

}