part of 'package:diplom/data/moor_db.dart'; 

@UseDao(tables: [Users, SymptomsTypes, SymptomsNames, SymptomsValues])
class SymptomsDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsDaoMixin {
  final AppDatabase db;

  SymptomsDao(this.db) : super(db);

  Future<void> addSymptomValue({
    required String userName,
    required String symptomTypeName,
    required String symptomName,
    required int value,
    required DateTime date,
  }) async {
    // Поиск пользователя по имени
    final userQuery = select(users)..where((u) => u.name.equals(userName));
    final user = await userQuery.getSingle();

    // Поиск типа симптома по названию
    final symptomTypeQuery = select(symptomsTypes)
      ..where((t) => t.type.equals(symptomTypeName));
    final symptomType = await symptomTypeQuery.getSingle();


    // Поиск имени симптома по типу и названию
    final symptomNameQuery = select(symptomsNames)
      ..where((n) =>
          n.type.equals(symptomType.id.toString()) &
          n.name.equals(symptomName));
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

  Future<List<SymptomDetails>> getSymptomsDetails(DateTime date) async {
    final query = customSelect(
      'SELECT sn.name AS symptomName, st.type AS symptomType, sv.value AS symptomValue '
      'FROM symptomsvalues AS sv '
      'JOIN symptomsnames AS sn ON sv.symptomNameId = sn.id '
      'JOIN symptomstypes AS st ON sn.typeId = st.id '
      'WHERE DATE(sv.date) = DATE(?)',
      readsFrom: {symptomsValues, symptomsNames, symptomsTypes},
      variables: [Variable.withDateTime(date)],
    );

    final results = await query.get();
    return results
        .map((row) => SymptomDetails(
              symptomName: row.read<String>('symptomName'),
              symptomType: row.read<String>('symptomType'),
              symptomValue: row.read<int>('symptomValue'),
            ))
        .toList();
  }
}
