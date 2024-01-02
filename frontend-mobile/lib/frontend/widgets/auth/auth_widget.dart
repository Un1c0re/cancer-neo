import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/requests/get_patient.dart';
import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';
import '../../screens/home/home_screen.dart';

class AuthWidget extends StatefulWidget {

  const AuthWidget({
    super.key,
    });

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  void _skipAuth() => Get.offAll(() => const HomeScreen());

  final controller = TextEditingController();

  void _getUser() async {
    await fetchPatientData(controller.text.replaceAll('+', '%2B'));
  }

  @override
  Widget build(BuildContext context) {

    final phoneInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      prefixIcon: const Icon(Icons.phone_outlined),
      prefixIconColor: AppColors.primaryColor,
      label: const Text('Телефон'),
      fillColor: Colors.white,
    );

    return SizedBox(
      height: DeviceScreenConstants.screenHeight,

      child: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: DeviceScreenConstants.screenHeight * 0.15),
            _LogoWidget(),
            SizedBox(height: DeviceScreenConstants.screenHeight * 0.1),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: phoneInputDecoration,
                          cursorColor: AppColors.primaryColor,
                          keyboardType: TextInputType.phone,
                        ),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton(
                        style: ButtonStyle(
                          padding:          const MaterialStatePropertyAll(EdgeInsets.all(5)),
                          minimumSize:      const MaterialStatePropertyAll(Size(60, 50)),
                          backgroundColor:  const MaterialStatePropertyAll(AppColors.primaryColor),
                          foregroundColor:  const MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: _getUser,
                        child: const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ],
                  ),
                ),
      
                const SizedBox(height: 10),
                
              ],
            ),

            SizedBox(height: DeviceScreenConstants.screenHeight * 0.25),

            const _FooterWidget(primaryColor: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Разработано BO-11-5',
        style: TextStyle(
          color: primaryColor,
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 25),
          Text('NeoGO', 
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          SizedBox(height: 25),
          Text('Ваш мобильный ассистент',
            style: TextStyle(
              color: AppColors.activeColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
