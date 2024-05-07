part of 'package:cancerneo/data/moor_db.dart'; 


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

  Future<void> initDocTypes() async {
    final query = select(doctypes)..limit(1);
    final List<Doctype> types = await query.get();
    final bool doTypesExist = types.isNotEmpty;

    if(doTypesExist) return;

    List<String> docTypesList = dotenv.env['DOC_TYPES']!.split(',');
    for(int i = 0; i < docTypesList.length; i++) {
      await into(doctypes).insert(DoctypesCompanion(
          name: Value(docTypesList[i]),
      ));
    }
  }

  Future<String> getDocType(id) async {
    final doctype = await (select(doctypes)..where((doctype) => doctype.id.equals(id))).getSingleOrNull();
    return doctype!.name; 
  }
}