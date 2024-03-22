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
        .insert(SymptomsTypesCompanion.insert(type: type1));

    await into(symptomsTypes)
        .insert(SymptomsTypesCompanion.insert(type: type2));

    await into(symptomsTypes)
        .insert(SymptomsTypesCompanion.insert(type: type3));
  }

  Future<void> addSymptomNames() async {
    final String name1 = "тревожность";
    final String name2 = "Головная боль";
    final String name3 = "мигрень";
    final String name4 = "кашель";

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type: Value(2),
      name: Value(name1),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type: Value(2),
      name: Value(name2),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type: Value(1),
      name: Value(name3),
    ));

    await into(symptomsNames).insert(SymptomsNamesCompanion(
      type: Value(1),
      name: Value(name4),
    ));
  }

  Future<void> addSymptomValue({
    required String symptomTypeName,
    required String symptomName,
    required int value,
    required DateTime date,
  }) async {
    final userQuery = select(users)..where((u) => u.id.equals(0));
    final user = await userQuery.getSingle();

    // Поиск типа симптома по названию
    final symptomTypeQuery = select(symptomsTypes)
      ..where((t) => t.type.equals(symptomTypeName));
    final symptomType = await symptomTypeQuery.getSingle();

    // Поиск имени симптома по типу и названию
    final symptomNameQuery = select(symptomsNames)
      ..where(
          (n) => n.type.equals(symptomType.id) & n.name.equals(symptomName));
    final symptomNameEntry = await symptomNameQuery.getSingle();

    // Добавление значения симптома
    await into(symptomsValues).insert(SymptomsValuesCompanion.insert(
      ownerId: user.id,
      name: symptomNameEntry.id,
      value: Value(value),
      date: date,
    ));
  }

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
    print('DATE HEEEERE: ${date}');

    for (int i = 0; i < namesID.length; i++) {
      await into(symptomsValues).insert(
        SymptomsValuesCompanion.insert(
          ownerId: 0,
          date: date,
          // date: DateTime(date.year, date.month, date.day),
          name: namesID[i],
          value: Value(0),
        ),
      );
    }
  }

  Future<List<SymptomDetails>> getSymptomsDetails(DateTime date) async {
    print('DAAAAAAAATE --- ${date}');
    final query = customSelect(
      'SELECT sn.name AS symptomName, st.type AS symptomType, sv.value AS symptomValue '
      'FROM symptoms_values AS sv '
      'JOIN symptoms_names AS sn ON sv.name = sn.id '
      'JOIN symptoms_types AS st ON sn.type = st.id '
      'WHERE DATE(sv.date) = DATE(?)',
      readsFrom: {symptomsValues, symptomsNames, symptomsTypes},
      variables: [Variable.withDateTime(date)],
    );

    final results = await query.get().then(
      (rows) {
        return rows.map((row) => SymptomDetails(
              id: row.read<int>('id'),
              symptomName: row.read<String>('symptomName'),
              symptomType: row.read<String>('symptomType'),
              symptomValue: row.read<int>('symptomValue'),
            )).toList();
      }
    );

    final query1 = customSelect(
      'SELECT * FROM symptoms_values',
      readsFrom: {symptomsValues},
    );
    final valuesRes = await query1.get();
    List<Map<String, dynamic>> valuesInfo = valuesRes.map(
      (row) {
        return {
          'id': row.read<int>('id'),
          'name': row.read<int>('name'),
          'date': row.read<DateTime>('date'),
          'value': row.read<int>('value'),
        };
      }).toList();

      print(valuesInfo);

    return results;

  }
}
