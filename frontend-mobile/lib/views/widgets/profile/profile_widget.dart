import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/medkit/medkit_screen.dart';
import 'package:diplom/views/screens/profile/community_sreen.dart';
import 'package:diplom/views/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../utils/navbar_icons.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('neo go'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ProfileCard(),
              SizedBox(height: 25),
              _SettingsButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class _ProfileCard extends StatefulWidget {

  const _ProfileCard({super.key});
  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  String userName   = 'Тестов Тест Тестович';
  String birthdate  = '01.01.20001';
  String disease    = '01.01.20001';
  String phone      = '+79991112233';
  String doctor     = 'Врачев Врач Врачович';

  bool isDataFetched = false;

  void _editProfile() => Get.to(() => const EditProfileScreen());
 
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: AppStyleCard(
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
      ),
    );
  }
}



class SettingsButtonsData {
  final IconData icon;
  final String label;
  final dynamic dest;

  SettingsButtonsData(this.icon, this.label, this.dest);
}

class _SettingsButtons extends StatelessWidget {
  _SettingsButtons();

  final List<SettingsButtonsData> data = [
    SettingsButtonsData(MyFlutterApp.pills, 'Аптечка',
        () => Get.to(() => const MedKitScreen())),
    SettingsButtonsData(Icons.people_alt_outlined, 'Сообщества',
        () => Get.to(() => const CommunityScreen())),
    SettingsButtonsData(Icons.phone_rounded, 'Горячая линия поддержки', () {}),
    SettingsButtonsData(Icons.help_outline_rounded, 'Помощь', () {}),
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
                          onTap: () => content.dest(),
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
