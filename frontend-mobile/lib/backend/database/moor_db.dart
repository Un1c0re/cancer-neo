import 'package:moor_flutter/moor_flutter.dart';


part 'moor_db.g.dart';

class GradeSymptoms extends Table {
  IntColumn get id    => integer().autoIncrement()();
  IntColumn get year  => integer()();
  IntColumn get month => integer()();
  IntColumn get day   => integer()();
  IntColumn get value => integer().withDefault(const Constant(0))();
}

class BoolSymptoms extends Table {
  IntColumn   get id      => integer().autoIncrement()();
  IntColumn   get year    => integer()();
  IntColumn   get month   => integer()();
  IntColumn   get day     => integer()();
  BoolColumn  get value   => boolean().withDefault(const Constant(false))();
}


class Docs extends Table {
  IntColumn       get id        => integer().autoIncrement()();
  TextColumn      get docName   => text()();
  TextColumn      get docPlace  => text()();
  TextColumn      get docNotes  => text()();
  DateTimeColumn  get docDate   => dateTime()();
  BlobColumn      get pdfFile   => blob().nullable()();
}


@UseMoor(tables: [GradeSymptoms, BoolSymptoms, Docs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(
    FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite',
      logStatements: true,
    ));

    Future insertDocs(String text, DateTime date, Uint8List pdfBytes) {
    return into(Docs as TableInfo<Table, dynamic>).insert(
      DocsCompanion.insert(
        docName:  text,
        docPlace: text,
        docNotes: text,
        docDate:  date,
        pdfFile:  Value(pdfBytes),
      ),
    );
  } 
  
  @override
  int get schemaVersion => 1;

  Stream<List<GradeSymptom>> watchAllGradeSymptoms() => select(gradeSymptoms).watch();
  Stream<List<BoolSymptom>> watchAllBoolSymptoms() => select(boolSymptoms).watch();
  Stream<List<Doc>> watchAllDocs() => select(docs).watch();

  Future insertGradeSymptom(GradeSymptom symptom) => into(gradeSymptoms).insert(symptom);
  Future updateGradeSymptom(GradeSymptom symptom) => update(gradeSymptoms).replace(symptom);
  
  Future insertBoolSymptom(BoolSymptom symptom) => into(boolSymptoms).insert(symptom);
  Future updateBoolSymptom(BoolSymptom symptom) => update(boolSymptoms).replace(symptom);
  
  Future insertDoc(Doc doc) => into(docs).insert(doc);
  Future updateDoc(Doc doc) => update(docs).replace(doc);
  Future deleteDoc(Doc doc) => delete(docs).delete(doc);
}
//  flutter packages pub run build_runner watch