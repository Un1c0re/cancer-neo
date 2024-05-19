import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/views/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrueHomeScreen extends StatefulWidget {
  const TrueHomeScreen({super.key});

  @override
  State<TrueHomeScreen> createState() => _TrueHomeScreenState();
}

class _TrueHomeScreenState extends State<TrueHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Здравствуйте'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CancerNEO - мобильный ассистент пациента',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.activeColor,
                fontSize: 20,
              ),
            ),
            Image(
              image: AssetImage('assets/images/neo1.png'),
              height: 100,
              width: 100,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: Column(
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
            ElevatedButton(
              onPressed: () => Get.offAll(const HomeScreen()),
              style: AppButtonStyle.basicButton,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Text(
                  'К приложению',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
