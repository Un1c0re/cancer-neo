part of 'package:diplom/data/moor_db.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  Future<void> initUser() async {
    final isUserExist = await (select(users)..where((user) => user.id.equals(0))).getSingleOrNull();
    if (isUserExist != null) return;
    
    User initUser = User.fromJson(json.decode(dotenv.env['INIT_USER']!));
    await into(users).insert(initUser);
  }

  Future<UserModel?> getUserdata() async {
    final user = await (select(users)..where((user) => user.id.equals(0))).getSingleOrNull();
    return user != null ? UserModel.fromMap(user.toJson()) : null;
  }

  Future<void> updateUser({
    required int userId,
    String? name,
    DateTime? birthdate,
    String? diseaseHistory,
    String? threatmentHistory,
  }) async {
    final updateUser = UsersCompanion(
      id: Value(userId),
      name: name != null ? Value(name) : const Value.absent(),
      birthdate: birthdate != null ? Value(birthdate) : const Value.absent(),
      deseaseHistory:
          diseaseHistory != null ? Value(diseaseHistory) : const Value.absent(),
      threatmentHistory: threatmentHistory != null
          ? Value(threatmentHistory)
          : const Value.absent(),
    );

    await (update(users)..where((tbl) => tbl.id.equals(userId)))
        .write(updateUser);
  }
}
