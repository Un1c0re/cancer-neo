import 'package:diplom/models/symptom_type_model.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSymptomWidget extends StatefulWidget {
  const AddSymptomWidget({super.key});

  @override
  State<AddSymptomWidget> createState() => _AddSymptomWidgetState();
}

class _AddSymptomWidgetState extends State<AddSymptomWidget> {
  final _nameInputController = TextEditingController();

  void _cancel() => Get.back();

  void _submit() {
    Get.back();

    Get.snackbar(
      'Успешно!',
      'Симптом добавлен',
      backgroundColor: Colors.tealAccent.withOpacity(0.4),
      colorText: Colors.teal.shade900,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название симптома'),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: DeviceScreenConstants.screenHeight*0.65,),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: DeviceScreenConstants.screenHeight * 0.1),
            child: AppStyleCard(
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: nameInputDecoration,
                      cursorColor: AppColors.activeColor,
                      controller: _nameInputController,
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: AppButtonStyle.outlinedRedRoundedButton,
                    onPressed: _cancel,
                    child: const Text('Отменить'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: AppButtonStyle.filledRoundedButton,
                    onPressed: () {
                      service.database.symptomsNamesDao.addSymptomName(
                        _nameInputController.text.trim()
                      );
                      _submit();
                    },
                    child: const Text('Подтвердить'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}