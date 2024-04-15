import 'package:diplom/controllers/symptoms_controller.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoolSymptomWidget extends StatelessWidget {
  final int symptomID;
  final String label;
  final int value;

  const BoolSymptomWidget({
    super.key,
    required this.symptomID,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: DeviceScreenConstants.screenWidth * 0.4,
        maxHeight: 65,
      ),
      child: Obx(() {
        final BoolSymptomController controller = Get.put(
          BoolSymptomController(value.toDouble()),
          tag: '$symptomID',
        );

        int symptomValue = controller.currentValue.toInt();
        final bool isSelected = symptomValue == 0 ? false : true;
        return Stack(
          children: [
            AppStyleCard(
              backgroundColor:
                  isSelected ? AppColors.activeColor : Colors.white,
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    if (symptomValue == 0) {
                      controller.updateBoolValue(1);
                    } else {
                      controller.updateBoolValue(0);
                    }
                    controller.updateSymptomValueInDB(symptomID, symptomValue);
                  },
                  splashColor: AppColors.splashColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
