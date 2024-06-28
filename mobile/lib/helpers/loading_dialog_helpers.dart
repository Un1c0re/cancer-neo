import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/utils/pdf_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Пользователь не может закрыть диалог нажатием вне его
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: DeviceScreenConstants.screenHeight * 0.15,
            maxWidth: DeviceScreenConstants.screenWidth * 0.9,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ), // Текст сообщения
              const CircularProgressIndicator(
                color: AppColors.activeColor,
              ), // Индикатор загрузки
            ],
          ),
        ),
      );
    },
  );
}

void showDateRangePickerDialog(
  BuildContext context,
  Function onSubmit,
  Function updateParentState,
) {
  DateRangePickerController controller = DateRangePickerController();
  controller.selectedRange = PickerDateRange(
    DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
    DateTime(DateTime.now().year, DateTime.now().month, 1),
  );
  controller.displayDate = DateTime.now();
  PickerDateRange? selectedRange = controller.selectedRange;

  void handlePropertyChange(String propertyName) {
    if (propertyName == 'selectedRange') {
      selectedRange = controller.selectedRange;
    }
  }

  controller.addPropertyChangedListener(handlePropertyChange);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final startDate = customFormat
                .format(controller.selectedRange?.startDate ?? DateTime.now());
            final endDate = customFormat
                .format(controller.selectedRange?.endDate ?? DateTime.now());

            void onUpdate() {
              setState(() {});
              updateParentState();
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: DeviceScreenConstants.screenHeight * 0.3,
                  maxWidth: DeviceScreenConstants.screenWidth,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Пожалуйста, выберите промежуток',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'с   $startDate\nпо $endDate',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                            onPressed: () => selectDateRange(
                                context, controller, onUpdate),
                            icon: const Icon(
                              Icons.calendar_month,
                              color: AppColors.activeColor,
                              size: 40,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: AppButtonStyle.basicButton.copyWith(
                              side: const MaterialStatePropertyAll(BorderSide.none)
                            ),
                            onPressed: () {
                              Get.back();
                              generatePDF(context, selectedRange!.startDate!,
                                  selectedRange!.endDate!);
                            },
                            child: const Text(
                              'Подтвердить',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
}
