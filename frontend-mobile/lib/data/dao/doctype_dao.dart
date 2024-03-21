part of 'package:diplom/data/moor_db.dart'; 


@UseDao(tables: [Doctypes])
class DoctypesDao extends DatabaseAccessor<AppDatabase> with _$DoctypesDaoMixin {
  final AppDatabase db;

  DoctypesDao(this.db) : super(db);

  Future<List<DoctypeModel>> getAllDocTypes() async {
    final query = select(doctypes);
    final result = await query.get();
    return result
        .map((row) => DoctypeModel(
          id: row.id,
          name: row.name,
        ))
        .toList();
  }

  Future<void> initializeDocTypes() async {
    // category 1
    final String doctype1 = 'анализы';
    final String doctype2 = 'КТ';
    final String doctype3 = 'МРТ';
    final String doctype4 = 'Исследования';

    await into(doctypes).insert(DoctypesCompanion(
        name: Value(doctype1),
    ));
    await into(doctypes).insert(DoctypesCompanion(
        name: Value(doctype2),
    ));
    await into(doctypes).insert(DoctypesCompanion(
        name: Value(doctype3),
    ));
    await into(doctypes).insert(DoctypesCompanion(
        name: Value(doctype4),
    ));
  }

  Future<DoctypeModel> getDocType(id) async {
    final doctype = await (select(doctypes)..where((doctype) => doctype.id.equals(id))).getSingleOrNull();
    return DoctypeModel.fromMap(doctype!.toJson()); 
  }
}
