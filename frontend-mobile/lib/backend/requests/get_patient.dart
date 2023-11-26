import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../frontend/screens/edit/edit_profile_screen.dart';
import '../../frontend/screens/home/home_screen.dart';
import '../repositories/user_repository.dart';


Future<void> fetchPatientData(String phoneNumber) async {

  var dio = Dio();
  var url = 'http://10.13.13.70:8000/patient/?phone=$phoneNumber';
  var userRepo = Get.put(UserRepository());

  try {
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      if(response.data != null) {
        String jsondata = json.encode(response.data);
        await UserRepository.instance.saveUserData(jsondata);
        
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const  EditProfileScreen());
      }
    } else {
      // Обработка ошибки
      print('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    // Обработка исключений
    print('Error: $e');
  }

}

// Future<void> fetchPatientData(String phoneNumber) async {
//   final userRepo = Get.put(UserRepository());

  // var client = http.Client();
  // var response = await client.get(Uri.parse('http://10.13.13.70:8000/patient/?phone=$phoneNumber'), headers: {
  //   'Accept': 'application/json',
  //   'Content-Type': 'application/json; charset=UTF-8', // Установка кодировки UTF-8
  // });

//   // var url = Uri.parse('http://10.13.13.70:8000/patient/?phone=$phoneNumber');
//   // var response = await http.get(url);

//   try {
//     Response response = await Dio().get('https://example.com/data');
//     print(response.data);
//   } catch (e) {
//     print('Failed to fetch data: $e');
//   }

//   if (response.statusCode == 200) {
//     if (response.body != null) {
//       await UserRepository.instance.saveUserData(response.body);
//       Get.offAll(() => const HomeScreen());
//     }
//   } else {
//     print('nerabotaet');
//     // Обработка ошибки
//   }
// }
