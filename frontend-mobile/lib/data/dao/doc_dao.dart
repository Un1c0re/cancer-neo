part of 'package:diplom/data/moor_db.dart'; 


@UseDao(tables: [Users, Docs])
class DocsDao extends DatabaseAccessor<AppDatabase> with _$DocsDaoMixin {
  final AppDatabase db;

  DocsDao(this.db) : super(db);

  Future<List<DocSummary>> getAllDocSummaries() async {
    final query = select(docs);
    final result = await query.get();
    return result
        .map((row) => DocSummary(
          id: row.id,
          docName: row.docName,
          docDate: row.docDate!,
        ))
        .toList();
  }

  Future<DocModel?> getDoc(id) async {
    final doc = await (select(docs)..where((doc) => doc.id.equals(id))).getSingleOrNull();
    return doc != null ? DocModel.fromMap(doc.toJson()) : null;
  }

  Future<void> insertDoc({
    required String userName,
    required String docName,
    required DateTime docDate,
    required String docPlace,
    required String docNotes,
    Uint8List? pdfFile,
  }) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.name.equals(userName));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, добавляем документ
      await into(docs).insert(DocsCompanion(
        ownerId: Value(user.id),
        docName: Value(docName),
        docDate: Value(docDate),
        docPlace: Value(docPlace),
        docNotes: Value(docNotes),
        pdfFile: Value(pdfFile),
      ));
    } else {
      // Обработка случая, когда пользователь не найден
      print("Пользователь не найден");
    }
  }

  Future<void> updateDoc({
    required int docId,
    String? docName,
    DateTime? docDate,
    String? docPlace,
    String? docNotes,
    Uint8List? pdfFile,
  }) async {
    final docEntry = DocsCompanion(
      id: Value(docId),
      docName: docName != null ? Value(docName) : Value.absent(),
      docDate: docDate != null ? Value(docDate) : Value.absent(),
      docPlace: docPlace != null ? Value(docPlace) : Value.absent(),
      docNotes: docNotes != null ? Value(docNotes) : Value.absent(),
      pdfFile: pdfFile != null ? Value(pdfFile) : Value.absent(),
    );

    await (update(docs)..where((tbl) => tbl.id.equals(docId))).write(docEntry);
  }

  Future<void> deleteDoc(
      {required String userName, required String docName}) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.name.equals(userName));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, находим и удаляем документ
      final docQuery = select(docs)
        ..where(
            (tbl) => tbl.ownerId.equals(user.id) & tbl.docName.equals(docName));
      final doc = await docQuery.getSingleOrNull();
      if (doc != null) {
        await delete(docs).delete(doc);
      } else {
        // Обработка случая, когда документ не найден
        print("Документ не найден");
      }
    } else {
      // Обработка случая, когда пользователь не найден
      print("Пользователь не найден");
    }
  }
}
