import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:cancerneo/views/screens/home/home_screen.dart';
import 'package:cancerneo/views/screens/home/true_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Get.putAsync(() => DatabaseService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceScreenConstants.init(context);
    Intl.defaultLocale = 'ru_RU';
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      locale: const Locale('ru', 'RU'),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
        ),
      ],
      title: 'cancerNEO',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        fontFamily: 'Jost',
      ),
      debugShowCheckedModeBanner: false,
      home: const TrueHomeScreen(),
    );
  }
}
