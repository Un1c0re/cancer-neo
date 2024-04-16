part of 'package:diplom/data/moor_db.dart'; 


@UseDao(tables: [Users, Docs])
class DocsDao extends DatabaseAccessor<AppDatabase> with _$DocsDaoMixin {
  final AppDatabase db;

  DocsDao(this.db) : super(db);

  Future<List<DocSummaryModel>> getAllDocSummaries() async {
    final query = select(docs);
    final result = await query.get();
    return result
        .map((row) => DocSummaryModel(
          id: row.id,
          name: row.name,
          date: row.date!,
        ))
        .toList();
  }
  
  Future<List<DocSummaryModel>> getDocSummariesByTypeID(typeID) async {
    final query = select(docs)..where((tbl) => tbl.type_id.equals(typeID));
    final result = await query.get();
    return result
        .map((row) => DocSummaryModel(
          id: row.id,
          name: row.name,
          date: row.date!,
        ))
        .toList();
  }

  Future<DocModel?> getDoc(id) async {
    final doc = await (select(docs)..where((doc) => doc.id.equals(id))).getSingleOrNull();
    return doc != null ? DocModel.fromMap(doc.toJson()) : null;
  }

  Future<void> insertDoc({
    required String   name,
    required int      type_id,
    required DateTime date,
    required String   place,
    required String   notes,
    Uint8List?        file,
  }) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.id.equals(0));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, добавляем документ
      await into(docs).insert(DocsCompanion(
        owner_id: Value(user.id),
        name: Value(name),
        type_id: Value(type_id),
        date: Value(date),
        place: Value(place),
        notes: Value(notes),
        file: Value(file),
      ));
    }
  }

  Future<void> updateDoc({
    required int id,
    String? name,
    int? type_id,
    DateTime? date,
    String? place,
    String? notes,
    Uint8List? file,
  }) async {
    final docEntry = DocsCompanion(
      id: Value(id),
      name: name != null ? Value(name) : const Value.absent(),
      type_id: type_id != null ? Value(type_id) : const Value.absent(),
      date: date != null ? Value(date) : const Value.absent(),
      place: place != null ? Value(place) : const Value.absent(),
      notes: notes != null ? Value(notes) : const Value.absent(),
      file: file != null ? Value(file) : const Value.absent(),
    );

    await (update(docs)..where((tbl) => tbl.id.equals(id))).write(docEntry);
  }

  Future<void> deleteDoc(
      {required int id}) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.id.equals(0));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, находим и удаляем документ
      final docQuery = select(docs)
        ..where(
            (tbl) => tbl.owner_id.equals(user.id) & tbl.id.equals(id));
      final doc = await docQuery.getSingleOrNull();
      if (doc != null) {
        await delete(docs).delete(doc);
      }
    }
  }
}
