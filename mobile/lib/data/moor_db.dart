import 'dart:convert';

import 'package:diplom/models/doc_type_model.dart';
import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/models/symptom_type_model.dart';
import 'package:diplom/models/user_model.dart';
import 'package:diplom/models/docs_models.dart';
import 'package:diplom/models/symptom_value_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moor_flutter/moor_flutter.dart';


part 'moor_db.g.dart';

part 'package:diplom/data/dao/users_dao.dart';

part 'package:diplom/data/dao/doctypes_dao.dart';
part 'package:diplom/data/dao/docs_dao.dart';

part 'package:diplom/data/dao/symptoms_types_dao.dart';
part 'package:diplom/data/dao/symptoms_names_dao.dart';
part 'package:diplom/data/dao/symptoms_values_dao.dart';
part 'package:diplom/data/dao/daynotes_dao.dart';


////////////////////////////////// USERS //////////////////////////////////////

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get birthdate => dateTime().nullable()();
  TextColumn get deseaseHistory => text()();
  TextColumn get threatmentHistory => text()();
}

////////////////////////////////// CATEGORIES //////////////////////////////////

class Doctypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

////////////////////////////////// DOCUMENTS //////////////////////////////////

class Docs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get owner_id => integer().customConstraint('REFERENCES users(id)')();
  TextColumn get name => text()();
  IntColumn get type_id => integer().customConstraint('REFERENCES doctypes(id)')();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get place => text()();
  TextColumn get notes => text()();
  BlobColumn get file => blob().nullable()();
}

////////////////////////////////// SYMPTOMS ///////////////////////////////////

class SymptomsTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class SymptomsNames extends Table {
  IntColumn get id => integer().autoIncrement()();
  // ignore: non_constant_identifier_names
  IntColumn get type_id =>
      integer().customConstraint('REFERENCES symptomsTypes(id)')();
  TextColumn get name => text()();
}

class SymptomsValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  // ignore: non_constant_identifier_names
  IntColumn get owner_id => integer().customConstraint('REFERENCES users(id)')();
  DateTimeColumn get date => dateTime()();
  // ignore: non_constant_identifier_names
  IntColumn get name_id =>
      integer().customConstraint('REFERENCES symptomsNames(id)')();
  RealColumn get value => real().withDefault(const Constant(0.0))();
}

class DayNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  // ignore: non_constant_identifier_names
  IntColumn get owner_id => integer().customConstraint('REFERENCES users(id)')();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text()();
}


////////////////////////////////// APPDATABASE ////////////////////////////////

@UseMoor(
  tables: [Users, Doctypes, Docs, SymptomsTypes, SymptomsNames, SymptomsValues, DayNotes], 
  daos:   [UsersDao, DoctypesDao, DocsDao, SymptomsTypesDao, SymptomsNamesDao, SymptomsValuesDao, DayNotesDao]
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

//  dart run build_runner build