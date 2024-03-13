part of 'package:diplom/data/moor_db.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  Future<void> createUser() async {
    final newUser = UsersCompanion(
      id: Value(0),
      name: Value('test testovich'),
      birthdate: Value(DateTime.parse('2000-01-01')),
      deseaseHistory: Value('none'),
      threatmentHistory: Value('none'),
    );
    await into(users).insert(newUser);
  }

  Future<UserModel?> getUserdata() async {
    final user = await (select(users)..where((user) => user.id.equals(0))).getSingleOrNull();
    if (user != null) {
      final tt = user.toJson();
      final UserModel user_m = UserModel.fromMap(tt);
      return user_m;
    } else {
      return null;
    }
    // return user != null ? UserModel.fromMap(user.toJson()) : null;
  }

  Future<void> updateUser({
    required int userId,
    String? name,
    DateTime? birthdate,
    String? diseaseHistory,
    String? treatmentHistory,
  }) async {
    final updateUser = UsersCompanion(
      id: Value(userId),
      name: name != null ? Value(name) : const Value.absent(),
      birthdate: birthdate != null ? Value(birthdate) : const Value.absent(),
      deseaseHistory:
          diseaseHistory != null ? Value(diseaseHistory) : const Value.absent(),
      threatmentHistory: treatmentHistory != null
          ? Value(treatmentHistory)
          : const Value.absent(),
    );

    await (update(users)..where((tbl) => tbl.id.equals(userId)))
        .write(updateUser);
  }
}
