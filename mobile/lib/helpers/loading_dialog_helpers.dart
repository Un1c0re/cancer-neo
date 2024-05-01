import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';

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
