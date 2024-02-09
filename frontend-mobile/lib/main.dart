import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  // await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/', 
          page: () => MyApp(),
        ),
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
      home: HomeScreen(),
    );
  }
}
