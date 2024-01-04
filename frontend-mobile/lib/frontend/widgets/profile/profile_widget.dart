import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/controllers/auth_controller.dart';
import '../../../backend/repositories/user_repository.dart';
import '../../Theme/constants.dart';
import '../../Theme/navbar_icons.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final userRepo = Get.put(UserRepository());
  final controller = Get.put(AuthController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.33,
          child: SingleChildScrollView(
            child: _SettingsButtons(),
          ),
        ),
      ],
    );
  }
}

class SettingsButtonsData {
  final IconData icon;
  final String label;

  SettingsButtonsData(this.icon, this.label);
}

class _SettingsButtons extends StatelessWidget {
  _SettingsButtons();

  final List<SettingsButtonsData> data = [
    SettingsButtonsData(MyFlutterApp.pills, 'Аптечка'),
    SettingsButtonsData(Icons.people_alt_outlined, 'Сообщества'),
    SettingsButtonsData(Icons.phone_rounded, 'Горячая линия поддержки'),
    SettingsButtonsData(Icons.help_outline_rounded, 'Помощь'),
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: data
            .map((content) => ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 55,
                  ),
                  child: Stack(
                    children: [
                      AppStyleCard(
                        backgroundColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(content.icon),
                            const SizedBox(width: 15),
                            Text(
                              content.label,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          overlayColor: const MaterialStatePropertyAll(
                              AppColors.overlayColor),
                          splashColor: AppColors.splashColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
