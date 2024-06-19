import 'package:cancerneo/controllers/symptoms_controller.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: добавить минимальную валидацию данных

class MarkerSymptomWidget extends StatelessWidget {
  final int symptomID;
  final String label;
  final double value;

  MarkerSymptomWidget(
      {super.key,
      required this.symptomID,
      required this.label,
      required this.value});

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
      double? newValue = double.tryParse(valueInputController.text);
      if (newValue != null) {
        controller.updateSymptomValueInDB(symptomID, newValue);
      }
    });

    final valueInputDecoration = AppStyleTextFields.sharedDecoration;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: DeviceScreenConstants.screenWidth * 0.9,
      ),
      child: AppStyleCard(
          backgroundColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 200,
                ),
                child: Text(
                  label,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.redColor
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 90,
                ),
                child: TextField(
                  decoration: valueInputDecoration,
                  controller: valueInputController,
                  cursorColor: AppColors.redColor,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          )),
    );
  }
}
