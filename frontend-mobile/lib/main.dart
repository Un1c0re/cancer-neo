import 'package:diplom/data/moor_db.dart';
import 'package:diplom/providers/database_provider.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/screens/doc/add_doc_screen.dart';
import 'package:diplom/views/screens/doc/doc_screen.dart';
import 'package:diplom/views/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() async {
  // await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DatabaseService()).init(); // Инициализируем сервис базы данных
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceScreenConstants.init(context);
    return GetMaterialApp(
       initialRoute: '/',
      getPages: [
        GetPage(
          name: '/', 
          page: () => HomeScreen(),
        ),
      ],
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
