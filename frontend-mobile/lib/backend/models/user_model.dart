import 'dart:core';

class UserModel {
  final String? name;
  final String? birthdadte;
  final String? disease;
  final String? doctor_id;

  final String phone;

  const UserModel ({
    this.name,
    this.birthdadte,
    this.disease,
    this.doctor_id,
    required this.phone,
  });


  toJson() {
    return {
      'name': name,
      'birthdate':  birthdadte,
      'disease':    disease,
      'doctor_id':  doctor_id,
      'phone':      phone,
    };  
  }
}

