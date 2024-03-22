part of 'package:diplom/data/moor_db.dart';

@UseDao(tables: [Users, SymptomsTypes, SymptomsNames, SymptomsValues])
class SymptomsDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsDaoMixin {
  final AppDatabase db;

  SymptomsDao(this.db) : super(db);

  Future<void> addSymptomTypes() async {
    final type1 = 'bool';
    final type2 = 'grade';
    final type3 = 'num';

    await into(symptomsTypes)
        .insert(SymptomsTypesCompanion.insert(name: type1));

    await into(symptomsTypes)
        .insert(SymptomsTypesCompanion.insert(name: type2));

    await into(symptomsTypes)
        .insert(SymptomsTypesCompanion.insert(name: type3));
  }

  Future<void> addSymptomNames() async {
    final String name1 = "тревожность";
    final String name2 = "Головная боль";
    final String name3 = "мигрень";
    final String name4 = "кашель";

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type_id: Value(2),
      name: Value(name1),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type_id: Value(2),
      name: Value(name2),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type_id: Value(1),
      name: Value(name3),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type_id: Value(1),
      name: Value(name4),
    ));
  }

  // Future<void> addSymptomValue({
  //   required String symptomTypeName,
  //   required String symptomName,
  //   required int value,
  //   required DateTime date,
  // }) async {
  //   final userQuery = select(users)..where((u) => u.id.equals(0));
  //   final user = await userQuery.getSingle();

  //   // Поиск типа симптома по названию
  //   final symptomTypeQuery = select(symptomsTypes)
  //     ..where((t) => t.typeID.equals(symptomTypeName));
  //   final symptomType = await symptomTypeQuery.getSingle();

  //   // Поиск имени симптома по типу и названию
  //   final symptomNameQuery = select(symptomsNames)
  //     ..where(
  //         (n) => n.type.equals(symptomType.id) & n.name.equals(symptomName));
  //   final symptomNameEntry = await symptomNameQuery.getSingle();

  //   // Добавление значения симптома
  //   await into(symptomsValues).insert(SymptomsValuesCompanion.insert(
  //     ownerId: user.id,
  //     name: symptomNameEntry.id,
  //     value: Value(value),
  //     date: date,
  //   ));
  // }

  Future<void> updateSymptomValue({
    required int symptomValueId,
    int? newValue,
    DateTime? newDate,
  }) async {
    final symptomValueEntry = SymptomsValuesCompanion(
      id: Value(symptomValueId),
      value: newValue != null ? Value(newValue) : Value.absent(),
      date: Value.absent(),
    );
    await (update(symptomsValues)
          ..where((tbl) => tbl.id.equals(symptomValueId)))
        .write(symptomValueEntry);
  }

  Future<void> initializeSymptomsValues(DateTime date) async {
    final query = customSelect(
      'SELECT id FROM symptoms_names',
      readsFrom: {symptomsNames},
    );

    final namesID = await query.get().then((rows) {
      return rows.map((row) => row.read<int>('id')).toList();
    });

    print(namesID);

    for (int i = 0; i < namesID.length; i++) {
      await into(symptomsValues).insert(
        SymptomsValuesCompanion.insert(
          owner_id: 0,
          date: date,
          // date: DateTime(date.year, date.month, date.day),
          name_id: namesID[i],
          value: Value(0),
        ),
      );
    }
  }

  Future<List<SymptomDetails>> getSymptomsDetails(DateTime date) async {
    final query = customSelect(
      'SELECT sv.id AS symptomID, sn.name AS symptomName, st.name AS symptomType, sv.value AS symptomValue '
      'FROM symptoms_values AS sv '
      'JOIN symptoms_names AS sn ON sv.name_id = sn.id '
      'JOIN symptoms_types AS st ON sn.type_id = st.id '
      'WHERE DATE(sv.date) = DATE(?)',
      readsFrom: {symptomsValues, symptomsNames, symptomsTypes},
      variables: [Variable.withDateTime(date)]
    );

    final results = await query.get();
    // List<Map<String, dynamic>> chack = results.map((row) {
    //   return {
    //     'id': row.read<int>('symptomID'),
    //     'name': row.read<String>('symptomName'),
    //     'type': row.read<String>('symptomType'),
    //     'value':row.read<String>('symptomValue')
    //   };
    // }).toList();

    // print(chack);

    List<SymptomDetails> symptomsList = results
        .map(
          (row) => SymptomDetails(
            id: row.read<int>('symptomID'),
            symptomName: row.read<String>('symptomName'),
            symptomType: row.read<String>('symptomType'),
            symptomValue: row.read<int>('symptomValue'),
          ),
        )
        .toList();

    return symptomsList;
  }
}
