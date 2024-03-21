part of 'package:diplom/data/moor_db.dart'; 


@UseDao(tables: [DocTypes])
class DocTypesDao extends DatabaseAccessor<AppDatabase> with _$DocTypesDaoMixin {
  final AppDatabase db;

  DocTypesDao(this.db) : super(db);

  Future<List<DocTypeModel>> getAllDocTypes() async {
    final query = select(docTypes);
    final result = await query.get();
    return result
        .map((row) => DocTypeModel(
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

    await into(docTypes).insert(DocTypesCompanion(
        name: Value(doctype1),
    ));
    await into(docTypes).insert(DocTypesCompanion(
        name: Value(doctype2),
    ));
    await into(docTypes).insert(DocTypesCompanion(
        name: Value(doctype3),
    ));
    await into(docTypes).insert(DocTypesCompanion(
        name: Value(doctype4),
    ));
  }

  Future<DocTypeModel> getDocType(id) async {
    final doctype = await (select(docTypes)..where((doctype) => doctype.id.equals(id))).getSingleOrNull();
    return DocTypeModel.fromMap(doctype!.toJson()); 
  }
}
