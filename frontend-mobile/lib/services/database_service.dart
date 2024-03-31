import 'package:diplom/data/moor_db.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class DatabaseService extends GetxService {
  bool _initialized = false;
  late AppDatabase _database;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<DatabaseService> init() async {
    if (!_initialized) {
      _database = AppDatabase();
      await initializeDatabase();
      _initialized = true;
    }
    return this;
  }

  Future<void> initializeDatabase() async {
    if (_initialized) return;
    
    await _database.usersDao.initUser();
    await _database.doctypesDao.initDocTypes();
    await _database.symptomsTypesDao.initSymptomsTypes();
    await _database.symptomsNamesDao.initSymptomsNames();

  }

  AppDatabase get database => _database;
}
