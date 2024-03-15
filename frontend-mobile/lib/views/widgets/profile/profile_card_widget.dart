import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  void _getBack() => Get.back();
  void _getEdit() => Get.to(() => EditProfileScreen());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: DeviceScreenConstants.screenHeight * 0.8),
            child: AppStyleCard(
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBlock(
                      subtitle: 'Имя',
                      text: 'Тестов тест тестоич',
                    ),
                    SizedBox(height: 15),
                    TextBlock(
                      subtitle: 'Дата рождения',
                      text: '01-01-2001',
                    ),
                    SizedBox(height: 15),
                    TextBlock(
                      subtitle: 'Заболевание',
                      text: 'Тестрит тестов',
                    ),
                    SizedBox(height: 15),
                    TextBlock(
                      subtitle: 'Код заболевания по МКБ',
                      text: '1101',
                    ),
                    SizedBox(height: 15),
                    TextBlock(
                      subtitle: 'История болезни:',
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    ),
                    SizedBox(height: 15),
                    TextBlock(
                      subtitle: 'История лечения:',
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: AppButtonStyle.filledRoundedButton,
            onPressed: _getEdit,
            child: Text('Изменить данные'),
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
