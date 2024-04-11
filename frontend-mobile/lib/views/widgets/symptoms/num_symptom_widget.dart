import 'package:diplom/controllers/symptoms_controller.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumSymptomWidget extends StatelessWidget {
  final int symptomID;
  final String label;
  final int value;
  
  NumSymptomWidget({
    super.key, 
    required this.symptomID, 
    required this.label, 
    required this.value
  });


  late final valueInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
        // Создаем контроллер если он еще не был создан
    final controller = Get.put(
      NumSymptomController(value.toDouble()),
      tag: '$symptomID',
      permanent: true,
    );

    // Создаем TextEditingController только один раз
    final valueInputController = TextEditingController()
      ..text = value.toString();

    // Добавляем слушатель для обновления реактивного значения в контроллере
    valueInputController.addListener(() {
      int? newValue = int.tryParse(valueInputController.text);
      if (newValue != null) {
        controller.updateSymptomValueInDB(symptomID, newValue);
      }
    });

    final valueInputDecoration = AppStyleTextFields.sharedDecoration;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 70,
        maxWidth: DeviceScreenConstants.screenWidth * 0.9,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white, 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label, 
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 60,
                ),
                child: TextField(
                    decoration: valueInputDecoration,
                    controller: valueInputController,
                  ),
              ),
            ],
          ),
        )
      ),
    );
  }
}