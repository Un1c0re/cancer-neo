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
    required double value,
    required DateTime date,
  }) async {
    final userQuery = select(users)..where((u) => u.id.equals(0));
    final user = await userQuery.getSingle();

    // Поиск имени симптома по названию
    final symptomNameQuery = select(symptomsNames)
      ..where((n) => n.name.equals(symptomName));
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
    double? newValue,
    DateTime? newDate,
  }) async {
    final symptomValueEntry = SymptomsValuesCompanion(
      id: Value(symptomValueId),
      value: newValue != null ? Value(newValue) : const Value.absent(),
      date: const Value.absent(),
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
        variables: [Variable.withInt(date.millisecondsSinceEpoch ~/ 1000)]);

    final results = await query.get();

    List<SymptomDetails> symptomsList = results
        .map(
          (row) => SymptomDetails(
            id: row.read<int>('symptomID'),
            symptomName: row.read<String>('symptomName'),
            symptomType: row.read<String>('symptomType'),
            symptomValue: row.read<double>('symptomValue'),
          ),
        )
        .toList();

    return symptomsList;
  }

  Future<List<List<double>>> getSymptomsSortedByDayAndNameID(
      int symptomTypeId, DateTime monthStart, DateTime monthEnd) async {
    final query = customSelect(
      'SELECT sv.date, sv.value, sv.name_id '
      'FROM symptoms_values AS sv '
      'JOIN symptoms_names AS sn ON sv.name_id = sn.id '
      'WHERE sn.type_id = ? AND sv.date >= ? AND sv.date < ? '
      'ORDER BY sv.date, sv.name_id',
      readsFrom: {symptomsValues, symptomsNames},
      variables: [
        Variable.withInt(symptomTypeId),
        Variable.withDateTime(monthStart),
        Variable.withDateTime(monthEnd)
      ],
    );

    final result = await query.get();

    // Подготавливаем структуру для хранения результатов
    Map<int, List<double>> symptomsByDay = {};
    for (var row in result) {
      final date = row.read<DateTime>('date');
      final value = row.read<double>('value');

      symptomsByDay.putIfAbsent(date.day, () => []).add(value);
    }

    // Преобразуем карту в список списков для соблюдения порядка дней
    List<List<double>> sortedSymptoms = [];
    for (DateTime day = monthStart;
        day.isBefore(monthEnd);
        day = day.add(const Duration(days: 1))) {
      int dayKey = day.day;
      sortedSymptoms.add(symptomsByDay[dayKey] ?? []);
    }

    return sortedSymptoms;
  }

  Future<void> deleteSymptomValues(String symptomName) async {
    final query = select(symptomsNames)
      ..where((tbl) => tbl.name.equals(symptomName));
    final nameData = await query.getSingleOrNull();

    await (delete(symptomsValues)
          ..where((tbl) => tbl.name_id.equals(nameData!.id)))
        .go();
  }
}
