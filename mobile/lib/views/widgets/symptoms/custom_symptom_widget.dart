import 'package:cancerneo/controllers/symptoms_controller.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/views/screens/symptoms/edit_symptom_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSymptomWidget extends StatelessWidget {
  final int symptomID;
  final String label;
  final double value;
  final Function onUpdate;

  CustomSymptomWidget({
    super.key,
    required this.symptomID,
    required this.label,
    required this.value,
    required this.onUpdate,
  });

  void _editSymptom() => Get.to(() => EditSymptomScreen(
        onUpdate: onUpdate,
        oldName: label,
      ));

  late final valueInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Создаем контроллер если он еще не был создан
    final controller = Get.put(
      CustomSymptomController(value.toDouble()),
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
      child: Stack(
        children: [
          AppStyleCard(
              backgroundColor: Colors.white,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 90,
                      ),
                      child: TextField(
                        decoration: valueInputDecoration,
                        controller: valueInputController,
                        cursorColor: AppColors.activeColor,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton<String>(
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Скругление углов меню
                side: const BorderSide(
                    color: AppColors.passiveColor, width: 2), // Граница меню
              ),
              icon: const Icon(
                  Icons.more_horiz), // Вот иконка с тремя вертикальными точками
              onSelected: (String result) {
                // Действия при выборе элемента из меню
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: _editSymptom,
                  value: 'edit',
                  child: const Text(
                    'Изменить',
                    style: TextStyle(
                      color: AppColors.activeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () async {
                    await controller.deleteSymptomValueFromDB(label);
                    Get.delete<CustomSymptomController>(
                        tag: '$symptomID', force: true);
                    onUpdate();
                  },
                  value: 'delete',
                  child: const Text(
                    'Удалить',
                    style: TextStyle(
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
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
