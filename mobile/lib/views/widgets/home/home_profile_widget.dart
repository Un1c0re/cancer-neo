import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/views/screens/profile/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/models/user_model.dart';

import 'package:cancerneo/views/screens/profile/community_sreen.dart';
import 'package:cancerneo/views/screens/profile/profile_screen.dart';

import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/app_colors.dart';

class HomeProfileWidget extends StatefulWidget {
  final String appBarTitle;
  const HomeProfileWidget({
    super.key,
    required this.appBarTitle,
  });

  @override
  State<HomeProfileWidget> createState() => _HomeProfileWidgetState();
}

class _HomeProfileWidgetState extends State<HomeProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarTitle,
          style: const TextStyle(fontSize: 26),
        ),
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
              const _ProfileCard(),
              const SizedBox(height: 25),
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
  const _ProfileCard();
  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  bool isDataFetched = false;

  void _updateData() {
    setState(() {});
  }

  void _checkProfileCard() => Get.to(() => ProfileCardScreen(onUpdate: _updateData));

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    Future<UserModel?> getUser() async {
      return await databaseService.database.usersDao.getUserdata();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<UserModel?>(
                future: getUser(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final UserModel userdata = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          userdata.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Text(customFormat
                            .format(userdata.birthdate)
                            .toString()
                            .substring(0, 10)),
                      ],
                    );
                  }
                })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: AppButtonStyle.filledRoundedButton,
                  onPressed: _checkProfileCard,
                  child: const Text('посмотреть карточку пациента'),
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
    // SettingsButtonsData(MyFlutterApp.pills, 'Аптечка',
    //     () => Get.to(() => const MedKitScreen())),
    SettingsButtonsData(Icons.people_alt_outlined, 'Поддержка пациентов',
        () => Get.to(() => const CommunityScreen())),
    SettingsButtonsData(Icons.help_outline_rounded,
        'Как пользоаться приложением', () => Get.to(() => const HelpScreen())),
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 120,
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
