import 'package:diplom/data/moor_db.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class DatabaseService extends GetxService {
  late AppDatabase _database;

  void init() {
    _database = AppDatabase(); // Создание экземпляра базы данных
    // _database.usersDao.createUser();
    // _database.doctypesDao.initializeDocTypes();
  }

  AppDatabase get database => _database;
}
