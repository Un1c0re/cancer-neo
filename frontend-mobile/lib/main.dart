import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'frontend/Theme/constants.dart';

void main() {
  // await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      initialRoute: '/', // Указываем начальный маршрут
      getPages: [
        GetPage(name: '/', page: () => MyApp()), // Сопоставляем начальный маршрут с вашим MyApp
        // Другие страницы
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,  
        ),
        fontFamily: 'Jost',
      ),
    ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceScreenConstants.init(context);
    return MaterialApp(
      title: 'Diplom demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,  
        ),
        fontFamily: 'Jost',
      ),
      home: HomeScreen(), // Замените YourHomePage на вашу домашнюю страницу
    );
  }
}
