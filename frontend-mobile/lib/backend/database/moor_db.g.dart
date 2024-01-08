// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class GradeSymptom extends DataClass implements Insertable<GradeSymptom> {
  final int id;
  final int year;
  final int month;
  final int day;
  final int value;
  GradeSymptom(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.value});
  factory GradeSymptom.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return GradeSymptom(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year'])!,
      month: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}month'])!,
      day: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day'])!,
      value: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['day'] = Variable<int>(day);
    map['value'] = Variable<int>(value);
    return map;
  }

  GradeSymptomsCompanion toCompanion(bool nullToAbsent) {
    return GradeSymptomsCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      day: Value(day),
      value: Value(value),
    );
  }

  factory GradeSymptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return GradeSymptom(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      day: serializer.fromJson<int>(json['day']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'day': serializer.toJson<int>(day),
      'value': serializer.toJson<int>(value),
    };
  }

  GradeSymptom copyWith(
          {int? id, int? year, int? month, int? day, int? value}) =>
      GradeSymptom(
        id: id ?? this.id,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('GradeSymptom(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, month, day, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeSymptom &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.day == this.day &&
          other.value == this.value);
}

class GradeSymptomsCompanion extends UpdateCompanion<GradeSymptom> {
  final Value<int> id;
  final Value<int> year;
  final Value<int> month;
  final Value<int> day;
  final Value<int> value;
  const GradeSymptomsCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.day = const Value.absent(),
    this.value = const Value.absent(),
  });
  GradeSymptomsCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required int month,
    required int day,
    this.value = const Value.absent(),
  })  : year = Value(year),
        month = Value(month),
        day = Value(day);
  static Insertable<GradeSymptom> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? day,
    Expression<int>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (day != null) 'day': day,
      if (value != null) 'value': value,
    });
  }

  GradeSymptomsCompanion copyWith(
      {Value<int>? id,
      Value<int>? year,
      Value<int>? month,
      Value<int>? day,
      Value<int>? value}) {
    return GradeSymptomsCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradeSymptomsCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $GradeSymptomsTable extends GradeSymptoms
    with TableInfo<$GradeSymptomsTable, GradeSymptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradeSymptomsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int?> year = GeneratedColumn<int?>(
      'year', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int?> month = GeneratedColumn<int?>(
      'month', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int?> day = GeneratedColumn<int?>(
      'day', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int?> value = GeneratedColumn<int?>(
      'value', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, year, month, day, value];
  @override
  String get aliasedName => _alias ?? 'grade_symptoms';
  @override
  String get actualTableName => 'grade_symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<GradeSymptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
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
  GradeSymptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    return GradeSymptom.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $GradeSymptomsTable createAlias(String alias) {
    return $GradeSymptomsTable(attachedDatabase, alias);
  }
}

class BoolSymptom extends DataClass implements Insertable<BoolSymptom> {
  final int id;
  final int year;
  final int month;
  final int day;
  final bool value;
  BoolSymptom(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.value});
  factory BoolSymptom.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BoolSymptom(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year'])!,
      month: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}month'])!,
      day: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day'])!,
      value: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['day'] = Variable<int>(day);
    map['value'] = Variable<bool>(value);
    return map;
  }

  BoolSymptomsCompanion toCompanion(bool nullToAbsent) {
    return BoolSymptomsCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      day: Value(day),
      value: Value(value),
    );
  }

  factory BoolSymptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BoolSymptom(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      day: serializer.fromJson<int>(json['day']),
      value: serializer.fromJson<bool>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'day': serializer.toJson<int>(day),
      'value': serializer.toJson<bool>(value),
    };
  }

  BoolSymptom copyWith(
          {int? id, int? year, int? month, int? day, bool? value}) =>
      BoolSymptom(
        id: id ?? this.id,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('BoolSymptom(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, month, day, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoolSymptom &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.day == this.day &&
          other.value == this.value);
}

class BoolSymptomsCompanion extends UpdateCompanion<BoolSymptom> {
  final Value<int> id;
  final Value<int> year;
  final Value<int> month;
  final Value<int> day;
  final Value<bool> value;
  const BoolSymptomsCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.day = const Value.absent(),
    this.value = const Value.absent(),
  });
  BoolSymptomsCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required int month,
    required int day,
    this.value = const Value.absent(),
  })  : year = Value(year),
        month = Value(month),
        day = Value(day);
  static Insertable<BoolSymptom> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? day,
    Expression<bool>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (day != null) 'day': day,
      if (value != null) 'value': value,
    });
  }

  BoolSymptomsCompanion copyWith(
      {Value<int>? id,
      Value<int>? year,
      Value<int>? month,
      Value<int>? day,
      Value<bool>? value}) {
    return BoolSymptomsCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (value.present) {
      map['value'] = Variable<bool>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoolSymptomsCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $BoolSymptomsTable extends BoolSymptoms
    with TableInfo<$BoolSymptomsTable, BoolSymptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BoolSymptomsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int?> year = GeneratedColumn<int?>(
      'year', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int?> month = GeneratedColumn<int?>(
      'month', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int?> day = GeneratedColumn<int?>(
      'day', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<bool?> value = GeneratedColumn<bool?>(
      'value', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (value IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, year, month, day, value];
  @override
  String get aliasedName => _alias ?? 'bool_symptoms';
  @override
  String get actualTableName => 'bool_symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<BoolSymptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
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
  BoolSymptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BoolSymptom.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BoolSymptomsTable createAlias(String alias) {
    return $BoolSymptomsTable(attachedDatabase, alias);
  }
}

class Doc extends DataClass implements Insertable<Doc> {
  final int id;
  final String docName;
  final String docPlace;
  final String docNotes;
  final DateTime docDate;
  final Uint8List? pdfFile;
  Doc(
      {required this.id,
      required this.docName,
      required this.docPlace,
      required this.docNotes,
      required this.docDate,
      this.pdfFile});
  factory Doc.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Doc(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      docName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_name'])!,
      docPlace: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_place'])!,
      docNotes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_notes'])!,
      docDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_date'])!,
      pdfFile: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pdf_file']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['doc_name'] = Variable<String>(docName);
    map['doc_place'] = Variable<String>(docPlace);
    map['doc_notes'] = Variable<String>(docNotes);
    map['doc_date'] = Variable<DateTime>(docDate);
    if (!nullToAbsent || pdfFile != null) {
      map['pdf_file'] = Variable<Uint8List?>(pdfFile);
    }
    return map;
  }

  DocsCompanion toCompanion(bool nullToAbsent) {
    return DocsCompanion(
      id: Value(id),
      docName: Value(docName),
      docPlace: Value(docPlace),
      docNotes: Value(docNotes),
      docDate: Value(docDate),
      pdfFile: pdfFile == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFile),
    );
  }

  factory Doc.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Doc(
      id: serializer.fromJson<int>(json['id']),
      docName: serializer.fromJson<String>(json['docName']),
      docPlace: serializer.fromJson<String>(json['docPlace']),
      docNotes: serializer.fromJson<String>(json['docNotes']),
      docDate: serializer.fromJson<DateTime>(json['docDate']),
      pdfFile: serializer.fromJson<Uint8List?>(json['pdfFile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'docName': serializer.toJson<String>(docName),
      'docPlace': serializer.toJson<String>(docPlace),
      'docNotes': serializer.toJson<String>(docNotes),
      'docDate': serializer.toJson<DateTime>(docDate),
      'pdfFile': serializer.toJson<Uint8List?>(pdfFile),
    };
  }

  Doc copyWith(
          {int? id,
          String? docName,
          String? docPlace,
          String? docNotes,
          DateTime? docDate,
          Uint8List? pdfFile}) =>
      Doc(
        id: id ?? this.id,
        docName: docName ?? this.docName,
        docPlace: docPlace ?? this.docPlace,
        docNotes: docNotes ?? this.docNotes,
        docDate: docDate ?? this.docDate,
        pdfFile: pdfFile ?? this.pdfFile,
      );
  @override
  String toString() {
    return (StringBuffer('Doc(')
          ..write('id: $id, ')
          ..write('docName: $docName, ')
          ..write('docPlace: $docPlace, ')
          ..write('docNotes: $docNotes, ')
          ..write('docDate: $docDate, ')
          ..write('pdfFile: $pdfFile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, docName, docPlace, docNotes, docDate, pdfFile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doc &&
          other.id == this.id &&
          other.docName == this.docName &&
          other.docPlace == this.docPlace &&
          other.docNotes == this.docNotes &&
          other.docDate == this.docDate &&
          other.pdfFile == this.pdfFile);
}

class DocsCompanion extends UpdateCompanion<Doc> {
  final Value<int> id;
  final Value<String> docName;
  final Value<String> docPlace;
  final Value<String> docNotes;
  final Value<DateTime> docDate;
  final Value<Uint8List?> pdfFile;
  const DocsCompanion({
    this.id = const Value.absent(),
    this.docName = const Value.absent(),
    this.docPlace = const Value.absent(),
    this.docNotes = const Value.absent(),
    this.docDate = const Value.absent(),
    this.pdfFile = const Value.absent(),
  });
  DocsCompanion.insert({
    this.id = const Value.absent(),
    required String docName,
    required String docPlace,
    required String docNotes,
    required DateTime docDate,
    this.pdfFile = const Value.absent(),
  })  : docName = Value(docName),
        docPlace = Value(docPlace),
        docNotes = Value(docNotes),
        docDate = Value(docDate);
  static Insertable<Doc> custom({
    Expression<int>? id,
    Expression<String>? docName,
    Expression<String>? docPlace,
    Expression<String>? docNotes,
    Expression<DateTime>? docDate,
    Expression<Uint8List?>? pdfFile,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (docName != null) 'doc_name': docName,
      if (docPlace != null) 'doc_place': docPlace,
      if (docNotes != null) 'doc_notes': docNotes,
      if (docDate != null) 'doc_date': docDate,
      if (pdfFile != null) 'pdf_file': pdfFile,
    });
  }

  DocsCompanion copyWith(
      {Value<int>? id,
      Value<String>? docName,
      Value<String>? docPlace,
      Value<String>? docNotes,
      Value<DateTime>? docDate,
      Value<Uint8List?>? pdfFile}) {
    return DocsCompanion(
      id: id ?? this.id,
      docName: docName ?? this.docName,
      docPlace: docPlace ?? this.docPlace,
      docNotes: docNotes ?? this.docNotes,
      docDate: docDate ?? this.docDate,
      pdfFile: pdfFile ?? this.pdfFile,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (docName.present) {
      map['doc_name'] = Variable<String>(docName.value);
    }
    if (docPlace.present) {
      map['doc_place'] = Variable<String>(docPlace.value);
    }
    if (docNotes.present) {
      map['doc_notes'] = Variable<String>(docNotes.value);
    }
    if (docDate.present) {
      map['doc_date'] = Variable<DateTime>(docDate.value);
    }
    if (pdfFile.present) {
      map['pdf_file'] = Variable<Uint8List?>(pdfFile.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocsCompanion(')
          ..write('id: $id, ')
          ..write('docName: $docName, ')
          ..write('docPlace: $docPlace, ')
          ..write('docNotes: $docNotes, ')
          ..write('docDate: $docDate, ')
          ..write('pdfFile: $pdfFile')
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
  final VerificationMeta _docNameMeta = const VerificationMeta('docName');
  @override
  late final GeneratedColumn<String?> docName = GeneratedColumn<String?>(
      'doc_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  final VerificationMeta _docDateMeta = const VerificationMeta('docDate');
  @override
  late final GeneratedColumn<DateTime?> docDate = GeneratedColumn<DateTime?>(
      'doc_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _pdfFileMeta = const VerificationMeta('pdfFile');
  @override
  late final GeneratedColumn<Uint8List?> pdfFile = GeneratedColumn<Uint8List?>(
      'pdf_file', aliasedName, true,
      type: const BlobType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, docName, docPlace, docNotes, docDate, pdfFile];
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
    if (data.containsKey('doc_name')) {
      context.handle(_docNameMeta,
          docName.isAcceptableOrUnknown(data['doc_name']!, _docNameMeta));
    } else if (isInserting) {
      context.missing(_docNameMeta);
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
    if (data.containsKey('doc_date')) {
      context.handle(_docDateMeta,
          docDate.isAcceptableOrUnknown(data['doc_date']!, _docDateMeta));
    } else if (isInserting) {
      context.missing(_docDateMeta);
    }
    if (data.containsKey('pdf_file')) {
      context.handle(_pdfFileMeta,
          pdfFile.isAcceptableOrUnknown(data['pdf_file']!, _pdfFileMeta));
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $GradeSymptomsTable gradeSymptoms = $GradeSymptomsTable(this);
  late final $BoolSymptomsTable boolSymptoms = $BoolSymptomsTable(this);
  late final $DocsTable docs = $DocsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [gradeSymptoms, boolSymptoms, docs];
}
