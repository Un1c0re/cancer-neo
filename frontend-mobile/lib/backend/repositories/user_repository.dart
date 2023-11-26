import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final database = FirebaseDatabase.instance.ref().child('/users');
  
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

  Future<String> _getUserIdByPhone(String userPhone) async {
    DatabaseEvent event = await database.orderByChild('phone').equalTo(userPhone).once();
    final data = jsonDecode(jsonEncode(event.snapshot.value)); 
    String uuid = data.keys.first;

    return uuid;
  }

  void createUserIfNotExist(UserModel user) async {
    
    DatabaseEvent event = await database.orderByChild('phone').equalTo(user.phone).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      uuid = const Uuid().v4();
      
      database.child(uuid).set(user.toJson())
      .then((_) => _saveUserId(uuid))
      .catchError((onError)=> print('Error saving data: $onError'));
    } else {
      uuid = await _getUserIdByPhone(user.phone);
      _saveUserId(uuid);
    }
  }
}

//   Future<Map<String, dynamic>> getUserData() async {
//     uuid = await _getUserId();
//     DatabaseEvent event = await database.child(uuid).once();
//     DataSnapshot snapshot = event.snapshot;
//     return jsonDecode(jsonEncode(snapshot.value));
//   }

//   void updateUserData() {
    
//   }
// }
