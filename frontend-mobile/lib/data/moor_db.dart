import 'package:diplom/models/doc_type_model.dart';
import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/models/user_model.dart';
import 'package:diplom/models/docs_models.dart';
import 'package:diplom/models/symptoms_models.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

part 'package:diplom/data/dao/user_dao.dart';
part 'package:diplom/data/dao/doc_type_dao.dart';
part 'package:diplom/data/dao/doc_dao.dart';
part 'package:diplom/data/dao/symptom_dao.dart';
part 'package:diplom/data/dao/daynote_dao.dart';


////////////////////////////////// USERS //////////////////////////////////////

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get birthdate => dateTime().nullable()();
  TextColumn get deseaseHistory => text()();
  TextColumn get threatmentHistory => text()();
}

////////////////////////////////// CATEGORIES //////////////////////////////////

class DocTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

////////////////////////////////// DOCUMENTS //////////////////////////////////

class Docs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerId => integer().customConstraint('REFERENCES users(id)')();
  TextColumn get docName => text()();
  IntColumn get docType => integer().customConstraint('REFERENCES doctypes(id)')();
  DateTimeColumn get docDate => dateTime().nullable()();
  TextColumn get docPlace => text()();
  TextColumn get docNotes => text()();
  BlobColumn get pdfFile => blob().nullable()();
}

////////////////////////////////// SYMPTOMS ///////////////////////////////////

class SymptomsTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
}

class SymptomsNames extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type =>
      text().customConstraint('REFERENCES symptomsTypes(id)')();
  TextColumn get name => text()();
}

class SymptomsValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerId => integer().customConstraint('REFERENCES users(id)')();
  DateTimeColumn get date => dateTime()();
  IntColumn get name =>
      integer().customConstraint('REFERENCES symptomsNames(id)')();
  IntColumn get value => integer().withDefault(const Constant(0))();
}

class DayNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerId => integer().customConstraint('REFERENCES users(id)')();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text()();
}

////////////////////////////////// APPDATABASE ////////////////////////////////

@UseMoor(
  tables: [Users, DocTypes, Docs, SymptomsTypes, SymptomsNames, SymptomsValues, DayNotes], 
  daos:   [UsersDao, DocTypesDao, DocsDao, SymptomsDao, DayNotesDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;
}
//  flutter packages pub run build_runner watch