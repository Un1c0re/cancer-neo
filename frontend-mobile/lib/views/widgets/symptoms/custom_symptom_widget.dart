import 'package:diplom/controllers/symptoms_controller.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSymptomWidget extends StatelessWidget {
  final int symptomID;
  final String label;
  final int value;
  final Function onUpdate;

  CustomSymptomWidget({
    super.key,
    required this.symptomID,
    required this.label,
    required this.value, 
    required this.onUpdate,
  });

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
      int? newValue = int.tryParse(valueInputController.text);
      if (newValue != null) {
        controller.updateSymptomValueInDB(symptomID, newValue);
      }
    });

    final valueInputDecoration = AppStyleTextFields.sharedDecoration;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: DeviceScreenConstants.screenHeight * 0.08,
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
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 60,
                        ),
                        child: TextField(
                          decoration: valueInputDecoration,
                          controller: valueInputController,
                        ),
                      ),
                      PopupMenuButton<String>(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Скругление углов меню
                          side: const BorderSide(
                              color: AppColors.passiveColor,
                              width: 2), // Граница меню
                        ),
                        icon: const Icon(Icons
                            .more_vert), // Вот иконка с тремя вертикальными точками
                        onSelected: (String result) {
                          // Действия при выборе элемента из меню
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text(
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
                              Get.delete<CustomSymptomController>(tag: '$symptomID', force: true);
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
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
