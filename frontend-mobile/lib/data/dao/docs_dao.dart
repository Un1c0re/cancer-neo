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
          docName: row.docName,
          docType: row.docType,
          docDate: row.docDate!,
        ))
        .toList();
  }

  Future<DocModel?> getDoc(id) async {
    final doc = await (select(docs)..where((doc) => doc.id.equals(id))).getSingleOrNull();
    return doc != null ? DocModel.fromMap(doc.toJson()) : null;
  }

  Future<void> insertDoc({
    required String   userName,
    required String   docName,
    required int      docType,
    required DateTime docDate,
    required String   docPlace,
    required String   docNotes,
    Uint8List?        pdfFile,
  }) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.name.equals(userName));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, добавляем документ
      await into(docs).insert(DocsCompanion(
        ownerId: Value(user.id),
        docName: Value(docName),
        docType: Value(docType),
        docDate: Value(docDate),
        docPlace: Value(docPlace),
        docNotes: Value(docNotes),
        pdfFile: Value(pdfFile),
      ));
    }
  }

  Future<void> updateDoc({
    required int docId,
    String? docName,
    int? docType,
    DateTime? docDate,
    String? docPlace,
    String? docNotes,
    Uint8List? pdfFile,
  }) async {
    final docEntry = DocsCompanion(
      id: Value(docId),
      docName: docName != null ? Value(docName) : const Value.absent(),
      docType: docType != null ? Value(docType) : const Value.absent(),
      docDate: docDate != null ? Value(docDate) : const Value.absent(),
      docPlace: docPlace != null ? Value(docPlace) : const Value.absent(),
      docNotes: docNotes != null ? Value(docNotes) : const Value.absent(),
      pdfFile: pdfFile != null ? Value(pdfFile) : const Value.absent(),
    );

    await (update(docs)..where((tbl) => tbl.id.equals(docId))).write(docEntry);
  }

  Future<void> deleteDoc(
      {required int docID}) async {
    // Находим пользователя по имени
    final userQuery = select(users)..where((tbl) => tbl.id.equals(0));
    final User? user = await userQuery.getSingleOrNull();

    if (user != null) {
      // Если пользователь найден, находим и удаляем документ
      final docQuery = select(docs)
        ..where(
            (tbl) => tbl.ownerId.equals(user.id) & tbl.id.equals(docID));
      final doc = await docQuery.getSingleOrNull();
      if (doc != null) {
        await delete(docs).delete(doc);
      }
    }
  }
}
