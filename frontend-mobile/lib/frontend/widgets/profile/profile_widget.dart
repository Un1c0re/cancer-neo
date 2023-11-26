import 'dart:convert';

import 'package:diplom/frontend/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/controllers/auth_controller.dart';
import '../../../backend/repositories/user_repository.dart';
import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';
import '../../Theme/navbar_icons.dart';
import '../../screens/edit/edit_profile_screen.dart';

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
    bool isUserLoggedIn = authController.isUserLoggedIn;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.3,
          child: _ProfileCard(isUserLogged: isUserLoggedIn),
        ),
        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.33,
          child: SingleChildScrollView(
            child: _SettingsButtons(),
          ),
        ),
        SizedBox(
          width: 280,
          height: 35,
          child: OutlinedButton(
            style: AppButtonStyle.outlinedRedRoundedButton.copyWith(),
            onPressed: () {
              authController.logout();
              UserRepository.instance.removeDataFromLocalStorage();
              Get.offAll(() => const AuthScreen());
            },
            child: const Text('Выйти  из аккаунта'),
          ),
        )
      ],
    );
  }
}

class _ProfileCard extends StatefulWidget {
  final bool isUserLogged;

  const _ProfileCard({super.key, required this.isUserLogged});
  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  final userRepo = Get.put(UserRepository());
  String userName = 'Тестов Тест Тестович';
  String birthdate = '01.01.20001';
  String disease = '01.01.20001';
  String phone = '+79991112233';
  String doctor = 'Врачев Врач Врачович';

  late bool _isUserLoggedIn;
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
    _isUserLoggedIn = widget.isUserLogged;
  }

  void _editProfile() {
    Get.to(() => const EditProfileScreen());
  }

  void _getUserData() async {
    if(!isDataFetched) {

      String rawData = await UserRepository.instance.getUserData();
      Map<String, dynamic> userdata = json.decode(rawData);

      setState(() {
        userName = userdata['name'];
        birthdate = userdata['birthdate'];
        disease = userdata['disease'];
        phone = userdata['phone'];
        doctor = userdata['doctor_id']['name'];
      });
      isDataFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_isUserLoggedIn) {
      _getUserData();
    }

    return AppStyleCard(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(birthdate),
              Text(phone),
              Text(disease),
              Text('Лечащий врач: $doctor'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: AppButtonStyle.filledRoundedButton,
                onPressed: _editProfile,
                child: const Text('изменить данные профиля'),
              ),
            ],
          ),
        ],
      ),
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
