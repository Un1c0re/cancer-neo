import 'dart:convert';

import 'package:flutter/widgets.dart';

Map<String, dynamic> buildDataJson(
  TextEditingController nameController, 
  TextEditingController birthdateController, 
  TextEditingController diseaseController, 
  TextEditingController phoneController,
  
  ) {
  return {
    'name':       nameController.text,
    'birthdate':  birthdateController.text,
    'disease':    diseaseController.text,
    'phone':      phoneController.text,
    'doctor_id': 0,
  };
}
