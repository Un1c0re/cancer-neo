// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final DateTime? birthdate;
  final String deseaseHistory;
  final String threatmentHistory;
  User(
      {required this.id,
      required this.name,
      this.birthdate,
      required this.deseaseHistory,
      required this.threatmentHistory});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      birthdate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birthdate']),
      deseaseHistory: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}desease_history'])!,
      threatmentHistory: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}threatment_history'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || birthdate != null) {
      map['birthdate'] = Variable<DateTime?>(birthdate);
    }
    map['desease_history'] = Variable<String>(deseaseHistory);
    map['threatment_history'] = Variable<String>(threatmentHistory);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      birthdate: birthdate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthdate),
      deseaseHistory: Value(deseaseHistory),
      threatmentHistory: Value(threatmentHistory),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      birthdate: serializer.fromJson<DateTime?>(json['birthdate']),
      deseaseHistory: serializer.fromJson<String>(json['deseaseHistory']),
      threatmentHistory: serializer.fromJson<String>(json['threatmentHistory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'birthdate': serializer.toJson<DateTime?>(birthdate),
      'deseaseHistory': serializer.toJson<String>(deseaseHistory),
      'threatmentHistory': serializer.toJson<String>(threatmentHistory),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          DateTime? birthdate,
          String? deseaseHistory,
          String? threatmentHistory}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        birthdate: birthdate ?? this.birthdate,
        deseaseHistory: deseaseHistory ?? this.deseaseHistory,
        threatmentHistory: threatmentHistory ?? this.threatmentHistory,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthdate: $birthdate, ')
          ..write('deseaseHistory: $deseaseHistory, ')
          ..write('threatmentHistory: $threatmentHistory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, birthdate, deseaseHistory, threatmentHistory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.birthdate == this.birthdate &&
          other.deseaseHistory == this.deseaseHistory &&
          other.threatmentHistory == this.threatmentHistory);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime?> birthdate;
  final Value<String> deseaseHistory;
  final Value<String> threatmentHistory;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.birthdate = const Value.absent(),
    this.deseaseHistory = const Value.absent(),
    this.threatmentHistory = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.birthdate = const Value.absent(),
    required String deseaseHistory,
    required String threatmentHistory,
  })  : name = Value(name),
        deseaseHistory = Value(deseaseHistory),
        threatmentHistory = Value(threatmentHistory);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime?>? birthdate,
    Expression<String>? deseaseHistory,
    Expression<String>? threatmentHistory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (birthdate != null) 'birthdate': birthdate,
      if (deseaseHistory != null) 'desease_history': deseaseHistory,
      if (threatmentHistory != null) 'threatment_history': threatmentHistory,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime?>? birthdate,
      Value<String>? deseaseHistory,
      Value<String>? threatmentHistory}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
      deseaseHistory: deseaseHistory ?? this.deseaseHistory,
      threatmentHistory: threatmentHistory ?? this.threatmentHistory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (birthdate.present) {
      map['birthdate'] = Variable<DateTime?>(birthdate.value);
    }
    if (deseaseHistory.present) {
      map['desease_history'] = Variable<String>(deseaseHistory.value);
    }
    if (threatmentHistory.present) {
      map['threatment_history'] = Variable<String>(threatmentHistory.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthdate: $birthdate, ')
          ..write('deseaseHistory: $deseaseHistory, ')
          ..write('threatmentHistory: $threatmentHistory')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _birthdateMeta = const VerificationMeta('birthdate');
  @override
  late final GeneratedColumn<DateTime?> birthdate = GeneratedColumn<DateTime?>(
      'birthdate', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deseaseHistoryMeta =
      const VerificationMeta('deseaseHistory');
  @override
  late final GeneratedColumn<String?> deseaseHistory = GeneratedColumn<String?>(
      'desease_history', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _threatmentHistoryMeta =
      const VerificationMeta('threatmentHistory');
  @override
  late final GeneratedColumn<String?> threatmentHistory =
      GeneratedColumn<String?>('threatment_history', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, birthdate, deseaseHistory, threatmentHistory];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birthdate')) {
      context.handle(_birthdateMeta,
          birthdate.isAcceptableOrUnknown(data['birthdate']!, _birthdateMeta));
    }
    if (data.containsKey('desease_history')) {
      context.handle(
          _deseaseHistoryMeta,
          deseaseHistory.isAcceptableOrUnknown(
              data['desease_history']!, _deseaseHistoryMeta));
    } else if (isInserting) {
      context.missing(_deseaseHistoryMeta);
    }
    if (data.containsKey('threatment_history')) {
      context.handle(
          _threatmentHistoryMeta,
          threatmentHistory.isAcceptableOrUnknown(
              data['threatment_history']!, _threatmentHistoryMeta));
    } else if (isInserting) {
      context.missing(_threatmentHistoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Doctype extends DataClass implements Insertable<Doctype> {
  final int id;
  final String name;
  Doctype({required this.id, required this.name});
  factory Doctype.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Doctype(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DoctypesCompanion toCompanion(bool nullToAbsent) {
    return DoctypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Doctype.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Doctype(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Doctype copyWith({int? id, String? name}) => Doctype(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Doctype(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doctype && other.id == this.id && other.name == this.name);
}

class DoctypesCompanion extends UpdateCompanion<Doctype> {
  final Value<int> id;
  final Value<String> name;
  const DoctypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DoctypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Doctype> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DoctypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return DoctypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $DoctypesTable extends Doctypes with TableInfo<$DoctypesTable, Doctype> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctypesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'doctypes';
  @override
  String get actualTableName => 'doctypes';
  @override
  VerificationContext validateIntegrity(Insertable<Doctype> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Doctype map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Doctype.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DoctypesTable createAlias(String alias) {
    return $DoctypesTable(attachedDatabase, alias);
  }
}

class Doc extends DataClass implements Insertable<Doc> {
  final int id;
  final int ownerId;
  final String docName;
  final int docType;
  final DateTime? docDate;
  final String docPlace;
  final String docNotes;
  final Uint8List? docFile;
  Doc(
      {required this.id,
      required this.ownerId,
      required this.docName,
      required this.docType,
      this.docDate,
      required this.docPlace,
      required this.docNotes,
      this.docFile});
  factory Doc.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Doc(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ownerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id'])!,
      docName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_name'])!,
      docType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_type'])!,
      docDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_date']),
      docPlace: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_place'])!,
      docNotes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_notes'])!,
      docFile: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_file']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    map['doc_name'] = Variable<String>(docName);
    map['doc_type'] = Variable<int>(docType);
    if (!nullToAbsent || docDate != null) {
      map['doc_date'] = Variable<DateTime?>(docDate);
    }
    map['doc_place'] = Variable<String>(docPlace);
    map['doc_notes'] = Variable<String>(docNotes);
    if (!nullToAbsent || docFile != null) {
      map['doc_file'] = Variable<Uint8List?>(docFile);
    }
    return map;
  }

  DocsCompanion toCompanion(bool nullToAbsent) {
    return DocsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      docName: Value(docName),
      docType: Value(docType),
      docDate: docDate == null && nullToAbsent
          ? const Value.absent()
          : Value(docDate),
      docPlace: Value(docPlace),
      docNotes: Value(docNotes),
      docFile: docFile == null && nullToAbsent
          ? const Value.absent()
          : Value(docFile),
    );
  }

  factory Doc.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Doc(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      docName: serializer.fromJson<String>(json['docName']),
      docType: serializer.fromJson<int>(json['docType']),
      docDate: serializer.fromJson<DateTime?>(json['docDate']),
      docPlace: serializer.fromJson<String>(json['docPlace']),
      docNotes: serializer.fromJson<String>(json['docNotes']),
      docFile: serializer.fromJson<Uint8List?>(json['docFile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'docName': serializer.toJson<String>(docName),
      'docType': serializer.toJson<int>(docType),
      'docDate': serializer.toJson<DateTime?>(docDate),
      'docPlace': serializer.toJson<String>(docPlace),
      'docNotes': serializer.toJson<String>(docNotes),
      'docFile': serializer.toJson<Uint8List?>(docFile),
    };
  }

  Doc copyWith(
          {int? id,
          int? ownerId,
          String? docName,
          int? docType,
          DateTime? docDate,
          String? docPlace,
          String? docNotes,
          Uint8List? docFile}) =>
      Doc(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        docName: docName ?? this.docName,
        docType: docType ?? this.docType,
        docDate: docDate ?? this.docDate,
        docPlace: docPlace ?? this.docPlace,
        docNotes: docNotes ?? this.docNotes,
        docFile: docFile ?? this.docFile,
      );
  @override
  String toString() {
    return (StringBuffer('Doc(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('docName: $docName, ')
          ..write('docType: $docType, ')
          ..write('docDate: $docDate, ')
          ..write('docPlace: $docPlace, ')
          ..write('docNotes: $docNotes, ')
          ..write('docFile: $docFile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ownerId, docName, docType, docDate, docPlace, docNotes, docFile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doc &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.docName == this.docName &&
          other.docType == this.docType &&
          other.docDate == this.docDate &&
          other.docPlace == this.docPlace &&
          other.docNotes == this.docNotes &&
          other.docFile == this.docFile);
}

class DocsCompanion extends UpdateCompanion<Doc> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<String> docName;
  final Value<int> docType;
  final Value<DateTime?> docDate;
  final Value<String> docPlace;
  final Value<String> docNotes;
  final Value<Uint8List?> docFile;
  const DocsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.docName = const Value.absent(),
    this.docType = const Value.absent(),
    this.docDate = const Value.absent(),
    this.docPlace = const Value.absent(),
    this.docNotes = const Value.absent(),
    this.docFile = const Value.absent(),
  });
  DocsCompanion.insert({
    this.id = const Value.absent(),
    required int ownerId,
    required String docName,
    required int docType,
    this.docDate = const Value.absent(),
    required String docPlace,
    required String docNotes,
    this.docFile = const Value.absent(),
  })  : ownerId = Value(ownerId),
        docName = Value(docName),
        docType = Value(docType),
        docPlace = Value(docPlace),
        docNotes = Value(docNotes);
  static Insertable<Doc> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<String>? docName,
    Expression<int>? docType,
    Expression<DateTime?>? docDate,
    Expression<String>? docPlace,
    Expression<String>? docNotes,
    Expression<Uint8List?>? docFile,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (docName != null) 'doc_name': docName,
      if (docType != null) 'doc_type': docType,
      if (docDate != null) 'doc_date': docDate,
      if (docPlace != null) 'doc_place': docPlace,
      if (docNotes != null) 'doc_notes': docNotes,
      if (docFile != null) 'doc_file': docFile,
    });
  }

  DocsCompanion copyWith(
      {Value<int>? id,
      Value<int>? ownerId,
      Value<String>? docName,
      Value<int>? docType,
      Value<DateTime?>? docDate,
      Value<String>? docPlace,
      Value<String>? docNotes,
      Value<Uint8List?>? docFile}) {
    return DocsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      docName: docName ?? this.docName,
      docType: docType ?? this.docType,
      docDate: docDate ?? this.docDate,
      docPlace: docPlace ?? this.docPlace,
      docNotes: docNotes ?? this.docNotes,
      docFile: docFile ?? this.docFile,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (docName.present) {
      map['doc_name'] = Variable<String>(docName.value);
    }
    if (docType.present) {
      map['doc_type'] = Variable<int>(docType.value);
    }
    if (docDate.present) {
      map['doc_date'] = Variable<DateTime?>(docDate.value);
    }
    if (docPlace.present) {
      map['doc_place'] = Variable<String>(docPlace.value);
    }
    if (docNotes.present) {
      map['doc_notes'] = Variable<String>(docNotes.value);
    }
    if (docFile.present) {
      map['doc_file'] = Variable<Uint8List?>(docFile.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('docName: $docName, ')
          ..write('docType: $docType, ')
          ..write('docDate: $docDate, ')
          ..write('docPlace: $docPlace, ')
          ..write('docNotes: $docNotes, ')
          ..write('docFile: $docFile')
          ..write(')'))
        .toString();
  }
}

class $DocsTable extends Docs with TableInfo<$DocsTable, Doc> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<int?> ownerId = GeneratedColumn<int?>(
      'owner_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES users(id)');
  final VerificationMeta _docNameMeta = const VerificationMeta('docName');
  @override
  late final GeneratedColumn<String?> docName = GeneratedColumn<String?>(
      'doc_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _docTypeMeta = const VerificationMeta('docType');
  @override
  late final GeneratedColumn<int?> docType = GeneratedColumn<int?>(
      'doc_type', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES doctypes(id)');
  final VerificationMeta _docDateMeta = const VerificationMeta('docDate');
  @override
  late final GeneratedColumn<DateTime?> docDate = GeneratedColumn<DateTime?>(
      'doc_date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _docPlaceMeta = const VerificationMeta('docPlace');
  @override
  late final GeneratedColumn<String?> docPlace = GeneratedColumn<String?>(
      'doc_place', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _docNotesMeta = const VerificationMeta('docNotes');
  @override
  late final GeneratedColumn<String?> docNotes = GeneratedColumn<String?>(
      'doc_notes', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _docFileMeta = const VerificationMeta('docFile');
  @override
  late final GeneratedColumn<Uint8List?> docFile = GeneratedColumn<Uint8List?>(
      'doc_file', aliasedName, true,
      type: const BlobType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ownerId, docName, docType, docDate, docPlace, docNotes, docFile];
  @override
  String get aliasedName => _alias ?? 'docs';
  @override
  String get actualTableName => 'docs';
  @override
  VerificationContext validateIntegrity(Insertable<Doc> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('doc_name')) {
      context.handle(_docNameMeta,
          docName.isAcceptableOrUnknown(data['doc_name']!, _docNameMeta));
    } else if (isInserting) {
      context.missing(_docNameMeta);
    }
    if (data.containsKey('doc_type')) {
      context.handle(_docTypeMeta,
          docType.isAcceptableOrUnknown(data['doc_type']!, _docTypeMeta));
    } else if (isInserting) {
      context.missing(_docTypeMeta);
    }
    if (data.containsKey('doc_date')) {
      context.handle(_docDateMeta,
          docDate.isAcceptableOrUnknown(data['doc_date']!, _docDateMeta));
    }
    if (data.containsKey('doc_place')) {
      context.handle(_docPlaceMeta,
          docPlace.isAcceptableOrUnknown(data['doc_place']!, _docPlaceMeta));
    } else if (isInserting) {
      context.missing(_docPlaceMeta);
    }
    if (data.containsKey('doc_notes')) {
      context.handle(_docNotesMeta,
          docNotes.isAcceptableOrUnknown(data['doc_notes']!, _docNotesMeta));
    } else if (isInserting) {
      context.missing(_docNotesMeta);
    }
    if (data.containsKey('doc_file')) {
      context.handle(_docFileMeta,
          docFile.isAcceptableOrUnknown(data['doc_file']!, _docFileMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Doc map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Doc.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DocsTable createAlias(String alias) {
    return $DocsTable(attachedDatabase, alias);
  }
}

class SymptomsType extends DataClass implements Insertable<SymptomsType> {
  final int id;
  final String name;
  SymptomsType({required this.id, required this.name});
  factory SymptomsType.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SymptomsType(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SymptomsTypesCompanion toCompanion(bool nullToAbsent) {
    return SymptomsTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory SymptomsType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SymptomsType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  SymptomsType copyWith({int? id, String? name}) => SymptomsType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SymptomsType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomsType && other.id == this.id && other.name == this.name);
}

class SymptomsTypesCompanion extends UpdateCompanion<SymptomsType> {
  final Value<int> id;
  final Value<String> name;
  const SymptomsTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SymptomsTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<SymptomsType> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SymptomsTypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return SymptomsTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTypesTable extends SymptomsTypes
    with TableInfo<$SymptomsTypesTable, SymptomsType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTypesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'symptoms_types';
  @override
  String get actualTableName => 'symptoms_types';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomsType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomsType map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SymptomsType.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SymptomsTypesTable createAlias(String alias) {
    return $SymptomsTypesTable(attachedDatabase, alias);
  }
}

class SymptomsName extends DataClass implements Insertable<SymptomsName> {
  final int id;
  final int type_id;
  final String name;
  SymptomsName({required this.id, required this.type_id, required this.name});
  factory SymptomsName.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SymptomsName(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type_id'] = Variable<int>(type_id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SymptomsNamesCompanion toCompanion(bool nullToAbsent) {
    return SymptomsNamesCompanion(
      id: Value(id),
      type_id: Value(type_id),
      name: Value(name),
    );
  }

  factory SymptomsName.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SymptomsName(
      id: serializer.fromJson<int>(json['id']),
      type_id: serializer.fromJson<int>(json['type_id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type_id': serializer.toJson<int>(type_id),
      'name': serializer.toJson<String>(name),
    };
  }

  SymptomsName copyWith({int? id, int? type_id, String? name}) => SymptomsName(
        id: id ?? this.id,
        type_id: type_id ?? this.type_id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SymptomsName(')
          ..write('id: $id, ')
          ..write('type_id: $type_id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type_id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomsName &&
          other.id == this.id &&
          other.type_id == this.type_id &&
          other.name == this.name);
}

class SymptomsNamesCompanion extends UpdateCompanion<SymptomsName> {
  final Value<int> id;
  final Value<int> type_id;
  final Value<String> name;
  const SymptomsNamesCompanion({
    this.id = const Value.absent(),
    this.type_id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SymptomsNamesCompanion.insert({
    this.id = const Value.absent(),
    required int type_id,
    required String name,
  })  : type_id = Value(type_id),
        name = Value(name);
  static Insertable<SymptomsName> custom({
    Expression<int>? id,
    Expression<int>? type_id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type_id != null) 'type_id': type_id,
      if (name != null) 'name': name,
    });
  }

  SymptomsNamesCompanion copyWith(
      {Value<int>? id, Value<int>? type_id, Value<String>? name}) {
    return SymptomsNamesCompanion(
      id: id ?? this.id,
      type_id: type_id ?? this.type_id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type_id.present) {
      map['type_id'] = Variable<int>(type_id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsNamesCompanion(')
          ..write('id: $id, ')
          ..write('type_id: $type_id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SymptomsNamesTable extends SymptomsNames
    with TableInfo<$SymptomsNamesTable, SymptomsName> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsNamesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _type_idMeta = const VerificationMeta('type_id');
  @override
  late final GeneratedColumn<int?> type_id = GeneratedColumn<int?>(
      'type_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES symptomsTypes(id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type_id, name];
  @override
  String get aliasedName => _alias ?? 'symptoms_names';
  @override
  String get actualTableName => 'symptoms_names';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomsName> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type_id')) {
      context.handle(_type_idMeta,
          type_id.isAcceptableOrUnknown(data['type_id']!, _type_idMeta));
    } else if (isInserting) {
      context.missing(_type_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomsName map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SymptomsName.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SymptomsNamesTable createAlias(String alias) {
    return $SymptomsNamesTable(attachedDatabase, alias);
  }
}

class SymptomsValue extends DataClass implements Insertable<SymptomsValue> {
  final int id;
  final int owner_id;
  final DateTime date;
  final int name_id;
  final double value;
  SymptomsValue(
      {required this.id,
      required this.owner_id,
      required this.date,
      required this.name_id,
      required this.value});
  factory SymptomsValue.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SymptomsValue(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      owner_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      name_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name_id'])!,
      value: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(owner_id);
    map['date'] = Variable<DateTime>(date);
    map['name_id'] = Variable<int>(name_id);
    map['value'] = Variable<double>(value);
    return map;
  }

  SymptomsValuesCompanion toCompanion(bool nullToAbsent) {
    return SymptomsValuesCompanion(
      id: Value(id),
      owner_id: Value(owner_id),
      date: Value(date),
      name_id: Value(name_id),
      value: Value(value),
    );
  }

  factory SymptomsValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SymptomsValue(
      id: serializer.fromJson<int>(json['id']),
      owner_id: serializer.fromJson<int>(json['owner_id']),
      date: serializer.fromJson<DateTime>(json['date']),
      name_id: serializer.fromJson<int>(json['name_id']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'owner_id': serializer.toJson<int>(owner_id),
      'date': serializer.toJson<DateTime>(date),
      'name_id': serializer.toJson<int>(name_id),
      'value': serializer.toJson<double>(value),
    };
  }

  SymptomsValue copyWith(
          {int? id,
          int? owner_id,
          DateTime? date,
          int? name_id,
          double? value}) =>
      SymptomsValue(
        id: id ?? this.id,
        owner_id: owner_id ?? this.owner_id,
        date: date ?? this.date,
        name_id: name_id ?? this.name_id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('SymptomsValue(')
          ..write('id: $id, ')
          ..write('owner_id: $owner_id, ')
          ..write('date: $date, ')
          ..write('name_id: $name_id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, owner_id, date, name_id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomsValue &&
          other.id == this.id &&
          other.owner_id == this.owner_id &&
          other.date == this.date &&
          other.name_id == this.name_id &&
          other.value == this.value);
}

class SymptomsValuesCompanion extends UpdateCompanion<SymptomsValue> {
  final Value<int> id;
  final Value<int> owner_id;
  final Value<DateTime> date;
  final Value<int> name_id;
  final Value<double> value;
  const SymptomsValuesCompanion({
    this.id = const Value.absent(),
    this.owner_id = const Value.absent(),
    this.date = const Value.absent(),
    this.name_id = const Value.absent(),
    this.value = const Value.absent(),
  });
  SymptomsValuesCompanion.insert({
    this.id = const Value.absent(),
    required int owner_id,
    required DateTime date,
    required int name_id,
    this.value = const Value.absent(),
  })  : owner_id = Value(owner_id),
        date = Value(date),
        name_id = Value(name_id);
  static Insertable<SymptomsValue> custom({
    Expression<int>? id,
    Expression<int>? owner_id,
    Expression<DateTime>? date,
    Expression<int>? name_id,
    Expression<double>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (owner_id != null) 'owner_id': owner_id,
      if (date != null) 'date': date,
      if (name_id != null) 'name_id': name_id,
      if (value != null) 'value': value,
    });
  }

  SymptomsValuesCompanion copyWith(
      {Value<int>? id,
      Value<int>? owner_id,
      Value<DateTime>? date,
      Value<int>? name_id,
      Value<double>? value}) {
    return SymptomsValuesCompanion(
      id: id ?? this.id,
      owner_id: owner_id ?? this.owner_id,
      date: date ?? this.date,
      name_id: name_id ?? this.name_id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (owner_id.present) {
      map['owner_id'] = Variable<int>(owner_id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (name_id.present) {
      map['name_id'] = Variable<int>(name_id.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsValuesCompanion(')
          ..write('id: $id, ')
          ..write('owner_id: $owner_id, ')
          ..write('date: $date, ')
          ..write('name_id: $name_id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $SymptomsValuesTable extends SymptomsValues
    with TableInfo<$SymptomsValuesTable, SymptomsValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsValuesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _owner_idMeta = const VerificationMeta('owner_id');
  @override
  late final GeneratedColumn<int?> owner_id = GeneratedColumn<int?>(
      'owner_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES users(id)');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _name_idMeta = const VerificationMeta('name_id');
  @override
  late final GeneratedColumn<int?> name_id = GeneratedColumn<int?>(
      'name_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES symptomsNames(id)');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double?> value = GeneratedColumn<double?>(
      'value', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [id, owner_id, date, name_id, value];
  @override
  String get aliasedName => _alias ?? 'symptoms_values';
  @override
  String get actualTableName => 'symptoms_values';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomsValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_owner_idMeta,
          owner_id.isAcceptableOrUnknown(data['owner_id']!, _owner_idMeta));
    } else if (isInserting) {
      context.missing(_owner_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name_id')) {
      context.handle(_name_idMeta,
          name_id.isAcceptableOrUnknown(data['name_id']!, _name_idMeta));
    } else if (isInserting) {
      context.missing(_name_idMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomsValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SymptomsValue.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SymptomsValuesTable createAlias(String alias) {
    return $SymptomsValuesTable(attachedDatabase, alias);
  }
}

class DayNote extends DataClass implements Insertable<DayNote> {
  final int id;
  final int owner_id;
  final DateTime date;
  final String note;
  DayNote(
      {required this.id,
      required this.owner_id,
      required this.date,
      required this.note});
  factory DayNote.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DayNote(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      owner_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(owner_id);
    map['date'] = Variable<DateTime>(date);
    map['note'] = Variable<String>(note);
    return map;
  }

  DayNotesCompanion toCompanion(bool nullToAbsent) {
    return DayNotesCompanion(
      id: Value(id),
      owner_id: Value(owner_id),
      date: Value(date),
      note: Value(note),
    );
  }

  factory DayNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DayNote(
      id: serializer.fromJson<int>(json['id']),
      owner_id: serializer.fromJson<int>(json['owner_id']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'owner_id': serializer.toJson<int>(owner_id),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String>(note),
    };
  }

  DayNote copyWith({int? id, int? owner_id, DateTime? date, String? note}) =>
      DayNote(
        id: id ?? this.id,
        owner_id: owner_id ?? this.owner_id,
        date: date ?? this.date,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('DayNote(')
          ..write('id: $id, ')
          ..write('owner_id: $owner_id, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, owner_id, date, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayNote &&
          other.id == this.id &&
          other.owner_id == this.owner_id &&
          other.date == this.date &&
          other.note == this.note);
}

class DayNotesCompanion extends UpdateCompanion<DayNote> {
  final Value<int> id;
  final Value<int> owner_id;
  final Value<DateTime> date;
  final Value<String> note;
  const DayNotesCompanion({
    this.id = const Value.absent(),
    this.owner_id = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
  });
  DayNotesCompanion.insert({
    this.id = const Value.absent(),
    required int owner_id,
    required DateTime date,
    required String note,
  })  : owner_id = Value(owner_id),
        date = Value(date),
        note = Value(note);
  static Insertable<DayNote> custom({
    Expression<int>? id,
    Expression<int>? owner_id,
    Expression<DateTime>? date,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (owner_id != null) 'owner_id': owner_id,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
    });
  }

  DayNotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? owner_id,
      Value<DateTime>? date,
      Value<String>? note}) {
    return DayNotesCompanion(
      id: id ?? this.id,
      owner_id: owner_id ?? this.owner_id,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (owner_id.present) {
      map['owner_id'] = Variable<int>(owner_id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayNotesCompanion(')
          ..write('id: $id, ')
          ..write('owner_id: $owner_id, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $DayNotesTable extends DayNotes with TableInfo<$DayNotesTable, DayNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayNotesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _owner_idMeta = const VerificationMeta('owner_id');
  @override
  late final GeneratedColumn<int?> owner_id = GeneratedColumn<int?>(
      'owner_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES users(id)');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, owner_id, date, note];
  @override
  String get aliasedName => _alias ?? 'day_notes';
  @override
  String get actualTableName => 'day_notes';
  @override
  VerificationContext validateIntegrity(Insertable<DayNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_owner_idMeta,
          owner_id.isAcceptableOrUnknown(data['owner_id']!, _owner_idMeta));
    } else if (isInserting) {
      context.missing(_owner_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DayNote.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DayNotesTable createAlias(String alias) {
    return $DayNotesTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $DoctypesTable doctypes = $DoctypesTable(this);
  late final $DocsTable docs = $DocsTable(this);
  late final $SymptomsTypesTable symptomsTypes = $SymptomsTypesTable(this);
  late final $SymptomsNamesTable symptomsNames = $SymptomsNamesTable(this);
  late final $SymptomsValuesTable symptomsValues = $SymptomsValuesTable(this);
  late final $DayNotesTable dayNotes = $DayNotesTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final DoctypesDao doctypesDao = DoctypesDao(this as AppDatabase);
  late final DocsDao docsDao = DocsDao(this as AppDatabase);
  late final SymptomsTypesDao symptomsTypesDao =
      SymptomsTypesDao(this as AppDatabase);
  late final SymptomsNamesDao symptomsNamesDao =
      SymptomsNamesDao(this as AppDatabase);
  late final SymptomsValuesDao symptomsValuesDao =
      SymptomsValuesDao(this as AppDatabase);
  late final DayNotesDao dayNotesDao = DayNotesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        doctypes,
        docs,
        symptomsTypes,
        symptomsNames,
        symptomsValues,
        dayNotes
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UsersDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
mixin _$DoctypesDaoMixin on DatabaseAccessor<AppDatabase> {
  $DoctypesTable get doctypes => attachedDatabase.doctypes;
}
mixin _$DocsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $DocsTable get docs => attachedDatabase.docs;
}
mixin _$SymptomsTypesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $SymptomsTypesTable get symptomsTypes => attachedDatabase.symptomsTypes;
  $SymptomsNamesTable get symptomsNames => attachedDatabase.symptomsNames;
  $SymptomsValuesTable get symptomsValues => attachedDatabase.symptomsValues;
}
mixin _$SymptomsNamesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $SymptomsTypesTable get symptomsTypes => attachedDatabase.symptomsTypes;
  $SymptomsNamesTable get symptomsNames => attachedDatabase.symptomsNames;
  $SymptomsValuesTable get symptomsValues => attachedDatabase.symptomsValues;
}
mixin _$SymptomsValuesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $SymptomsTypesTable get symptomsTypes => attachedDatabase.symptomsTypes;
  $SymptomsNamesTable get symptomsNames => attachedDatabase.symptomsNames;
  $SymptomsValuesTable get symptomsValues => attachedDatabase.symptomsValues;
}
mixin _$DayNotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $DayNotesTable get dayNotes => attachedDatabase.dayNotes;
}
