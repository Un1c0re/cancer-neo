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
    await Future.wait([
      _database.usersDao.createUser(),
      _database.doctypesDao.initializeDocTypes(),
      _database.symptomsDao.addSymptomTypes(),
      _database.symptomsDao.addSymptomNames(),
    ]);
  }

  AppDatabase get database => _database;
}
