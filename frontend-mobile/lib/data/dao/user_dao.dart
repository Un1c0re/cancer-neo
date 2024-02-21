part of 'package:diplom/data/moor_db.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  Future<void> updateUser({
    required int userId,
    String? name,
    DateTime? birthdate,
    String? diseaseHistory,
    String? treatmentHistory,
  }) async {
    final updateUser = UsersCompanion(
      id: Value(userId),
      name:           name                != null ? Value(name)             : const Value.absent(),
      birthdate:      birthdate           != null ? Value(birthdate)        : const Value.absent(),
      deseaseHistory: diseaseHistory      != null ? Value(diseaseHistory)   : const Value.absent(),
      threatmentHistory: treatmentHistory != null ? Value(treatmentHistory) : const Value.absent(),
    );

    await (update(users)..where((tbl) => tbl.id.equals(userId))).write(updateUser);
  }
}
