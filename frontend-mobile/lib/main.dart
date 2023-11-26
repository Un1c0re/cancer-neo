import 'package:diplom/frontend/Theme/app_style.dart';
import 'package:diplom/backend/repositories/auth_repository.dart';
import 'package:diplom/frontend/Theme/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
).then((value) => Get.put(AuthRepository()));
	
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,  
        ),
        fontFamily: 'Jost',
      ),
      home: const MyApp(),
    ));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    );
  }
}
