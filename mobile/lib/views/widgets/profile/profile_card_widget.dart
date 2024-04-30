import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:diplom/views/screens/profile/edit_profile_screen.dart';

import 'package:diplom/services/database_service.dart';
import 'package:diplom/models/user_model.dart';

import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';

class ProfileCardWidget extends StatefulWidget {
  final Function onUpdate;
  const ProfileCardWidget({
    super.key,
    required this.onUpdate,
  });

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  void _getEdit() => Get.to(() => EditProfileScreen(onUpdate: _updateData));

  void _updateData() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    Future<UserModel?> getUser() async {
      return await databaseService.database.usersDao.getUserdata();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: DeviceScreenConstants.screenHeight * 0.7,
              maxWidth: DeviceScreenConstants.screenWidth * 0.9,
            ),
            child: AppStyleCard(
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: FutureBuilder<UserModel?>(
                    future: getUser(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final UserModel userdata = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userdata.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Дата рождения',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              customFormat
                                  .format(userdata.birthdate)
                                  .toString()
                                  .substring(0, 10),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'История болезни',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              userdata.deseaseHistory,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'История лечения',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              userdata.threatmentHistory,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }
                    })),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: DeviceScreenConstants.screenWidth * 0.9),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: AppButtonStyle.filledRoundedButton.copyWith(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                    ),
                    onPressed: _getEdit,
                    child: const Text(
                      'Изменить данные',
                      style: TextStyle(fontSize: 18),
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

class TextBlock extends StatelessWidget {
  final String subtitle;
  final String text;
  const TextBlock({
    super.key,
    required this.subtitle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
