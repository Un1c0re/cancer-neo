import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/views/screens/home/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Здравствуйте'),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(15.0),
      //       bottomRight: Radius.circular(15.0),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/logo/logo.png'),
              height: 200,
              width: 200,
            ),
            const Text(
              'CancerNEO - мобильный ассистент пациента',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.activeColor,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: const Column(
                children: [
                  Text(
                    'Будьте грамотными! Будьте ответственными! Будьте защищенными!',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: AppColors.activeColor,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Жукова Л.Г., онколог, д.м.н., член-корреспондент РАН',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: AppColors.activeColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: DeviceScreenConstants.screenWidth * 0.6
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.offAll(const MenuScreen()),
                      style: AppButtonStyle.basicButton,
                      child: const Text(
                        'К приложению',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
