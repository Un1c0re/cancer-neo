part of 'package:diplom/data/moor_db.dart';

@UseDao(tables: [Users, SymptomsTypes, SymptomsNames, SymptomsValues])
class SymptomsValuesDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsValuesDaoMixin {
  final AppDatabase db;

  SymptomsValuesDao(this.db) : super(db);

  Future<void> initSymptomsValues(DateTime date) async {
    final query = customSelect(
      'SELECT id FROM symptoms_names',
      readsFrom: {symptomsNames},
    );

    final namesID = await query.get().then((rows) {
      return rows.map((row) => row.read<int>('id')).toList();
    });

    for (int i = 0; i < namesID.length; i++) {
      await into(symptomsValues).insert(
        SymptomsValuesCompanion.insert(
          owner_id: 0,
          date: DateTime(date.year, date.month, date.day),
          name_id: namesID[i],
          value: const Value(0),
        ),
      );
    }
  }

  Future<void> addSymptomValue({
    required String symptomName,
    required int value,
    required DateTime date,
  }) async {
    final userQuery = select(users)..where((u) => u.id.equals(0));
    final user = await userQuery.getSingle();

    // Поиск имени симптома по названию
    final symptomNameQuery = select(symptomsNames)
      ..where(
          (n) => n.name.equals(symptomName));
    final symptomNameEntry = await symptomNameQuery.getSingle();

    // Добавление значения симптома
    await into(symptomsValues).insert(SymptomsValuesCompanion.insert(
      owner_id: user.id,
      name_id: symptomNameEntry.id,
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

  Future<List<SymptomDetails>> getSymptomsDetails(DateTime date) async {
    final query = customSelect(
      'SELECT sv.id AS symptomID, sn.name AS symptomName, st.name AS symptomType, sv.value AS symptomValue '
      'FROM symptoms_values AS sv '
      'JOIN symptoms_names AS sn ON sv.name_id = sn.id '
      'JOIN symptoms_types AS st ON sn.type_id = st.id '
      'WHERE sv.date = ?',
      readsFrom: {symptomsValues, symptomsNames, symptomsTypes},
      variables: [Variable.withInt(date.millisecondsSinceEpoch ~/1000)]
    );

    final results = await query.get();

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

  Future<void>deleteSymptomValues(String symptomName) async {
    final query = select(symptomsNames)
      ..where((tbl) => tbl.name.equals(symptomName));
    final nameData = await query.getSingleOrNull();

    await (delete(symptomsValues)
      ..where((tbl) => tbl.name_id.equals(nameData!.id)))
      .go();
  }
}
