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

  final _typeInputController = TextEditingController();

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
    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название симптома'),
    );

    final typeInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('тип симптоматики'),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: DeviceScreenConstants.screenHeight * 0.5),
            child: AppStyleCard(
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      decoration: nameInputDecoration,
                      cursorColor: AppColors.activeColor,
                      controller: _nameInputController,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: typeInputDecoration,
                      cursorColor: AppColors.activeColor,
                      controller: _typeInputController,
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
                    onPressed: _submit,
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
