part of 'package:cancerneo/data/moor_db.dart';

@UseDao(tables: [Users, SymptomsTypes, SymptomsNames, SymptomsValues])
class SymptomsValuesDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsValuesDaoMixin {
  final AppDatabase db;

  SymptomsValuesDao(this.db) : super(db);

  // Инициализация значений симптомов
  // Выполняется каждый раз при выборе нового дня на экране home_symptoms_widget
  // Заполняет все симптомы нулями, чтобы они отображались
  // Иначе экран будет пустым
  Future<void> initSymptomsValues(DateTime date) async {
    // получаем имена симптомов
    final query = customSelect(
      'SELECT id FROM symptoms_names',
      readsFrom: {symptomsNames},
    );
    
    final namesID = await query.get().then((rows) {
      return rows.map((row) => row.read<int>('id')).toList();
    });

    // Вставляем нули для каждого симптома
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

  // Добавить значение  симптома
  Future<void> addSymptomValue({
    required String symptomName,
    required double value,
    required DateTime date,
  }) async {
    final userQuery = select(users)..where((u) => u.id.equals(0));
    final user = await userQuery.getSingle();

    // Поиск имени симптома
    final symptomNameQuery = select(symptomsNames)
      ..where((n) => n.name.equals(symptomName));
    final symptomNameEntry = await symptomNameQuery.getSingle();

    // Вставляем новое значение симптома
    await into(symptomsValues).insert(SymptomsValuesCompanion.insert(
      owner_id: user.id,
      name_id: symptomNameEntry.id,
      value: Value(value),
      date: date,
    ));
  }

  // Обновление значения  симптома
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

  // Получаем значения всех симптомов
  // Записываем их в список объектов SymptomDetails
  // Применяется на экране home_symptoms_widget
  Future<List<SymptomDetails>> getSymptomsDetails(DateTime date) async {
    
    // Объединяем данные из таблиц SymptomNames, SymptomTypes, SymptomValues
    // Фильтруем данные по выбранному дню
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

  // Получаем значения симптомов, отсортированных по дате и id
  Future<List<List<double>>> getSymptomsSortedByDayAndNameID(
      int symptomTypeId, DateTime monthStart, DateTime monthEnd) async {
    final query = customSelect(
      'SELECT sv.date, sv.value, sv.name_id '
      'FROM symptoms_values AS sv '
      'JOIN symptoms_names AS sn ON sv.name_id = sn.id '
      'WHERE sn.type_id = ? AND sv.date >= ? AND sv.date <= ? '
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

    // Преобразуем в список списков для соблюдения порядка дней
    List<List<double>> sortedSymptoms = [];
    for (DateTime day = monthStart;
        !day.isAfter(monthEnd);
        day = day.add(const Duration(days: 1))) {
      int dayKey = day.day;
      sortedSymptoms.add(symptomsByDay[dayKey] ?? []);
    }

    return sortedSymptoms;
  }

  Future<void> fix(String symptomName) async {}

  // Удалить  
  Future<void> deleteSymptomValues(String symptomName) async {
    final query = select(symptomsNames)
      ..where((tbl) => tbl.name.equals(symptomName));
    final nameData = await query.getSingleOrNull();
    if (nameData != null) {
      await (delete(symptomsValues)
            ..where((tbl) => tbl.name_id.equals(nameData.id)))
          .go();
    }
  }

  // Получить максимальное значение симптома из существующих по имени
  // Используюется для отображения графика численных симптомов
  Future<double> getMaxValueByName(String name) async {
    final query = customSelect(
      'SELECT MAX(sv.value) AS max_value '
      'FROM symptoms_values sv '
      'JOIN symptoms_names sn ON sv.name_id = sn.id '
      'WHERE sn.name = ?',
      readsFrom: {symptomsValues, symptomsNames},
      variables: [Variable.withString(name)],
    );

    final double? maxValue = await query
        .map((row) => row.read<double?>('max_value'))
        .getSingleOrNull();
    return maxValue ?? 0;
  }
}
