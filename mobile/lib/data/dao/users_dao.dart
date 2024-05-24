part of 'package:cancerneo/data/moor_db.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  // Инициализация пользователя
  // Выполняется один раз при первом старте программы
  Future<void> initUser() async {
    final isUserExist = await (select(users)..where((user) => user.id.equals(0))).getSingleOrNull();
    if (isUserExist != null) return;
    
    // считываем json данные пользователя из .env
    User initUser = User.fromJson(json.decode(dotenv.env['INIT_USER']!));
    await into(users).insert(initUser);
  }

  // Получить данные о пользователе
  Future<UserModel?> getUserdata() async {
    final user = await (select(users)..where((user) => user.id.equals(0))).getSingleOrNull();
    return user != null ? UserModel.fromMap(user.toJson()) : null;
  }

  // Изменить данные пользователя
  Future<void> updateUser({
    required int userId,
    String? name,
    DateTime? birthdate,
    String? disease,
    String? threatment,
  }) async {
    // с помощью компаньена создаем обновленную модель User
    final updateUser = UsersCompanion(
      id: Value(userId),
      name:       name      != null ? Value(name)       : const Value.absent(),
      birthdate:  birthdate != null ? Value(birthdate)  : const Value.absent(),
      deseaseHistory:     disease     != null ? Value(disease)    : const Value.absent(),
      threatmentHistory:  threatment  != null ? Value(threatment) : const Value.absent(),
    );
    // Вставляем измененные данные в БД
    await (update(users)..where((tbl) => tbl.id.equals(userId)))
        .write(updateUser);
  }
}
