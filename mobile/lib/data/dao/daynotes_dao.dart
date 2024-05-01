part of 'package:cancerneo/data/moor_db.dart';

@UseDao(tables: [Users, DayNotes])
class DayNotesDao extends DatabaseAccessor<AppDatabase>
    with _$DayNotesDaoMixin {
  final AppDatabase db;

  DayNotesDao(this.db) : super(db);

  Future<void> addDayNote({
    required DateTime date,
    required String note,
  }) async {
    final dayNoteEntry = DayNotesCompanion.insert(
      owner_id: 0,
      date: date,
      note: note,
    );
    await into(dayNotes).insert(dayNoteEntry);
  }

  Future<void> updateDayNote({
    String? note,
    required DateTime? date,
  }) async {
    final dayNoteEntry = DayNotesCompanion(
      note: note != null ? Value(note) : const Value.absent(),
      date: date != null ? Value(date) : const Value.absent(),
    );
    await (update(dayNotes)..where((tbl) => tbl.date.equals(date)))
        .write(dayNoteEntry);
  }

  Future<bool> ifDayNoteExists(DateTime date) async {
    final query = customSelect(
        'SELECT * FROM day_notes '
        'WHERE date = ?',
        readsFrom: {dayNotes},
        variables: [Variable.withInt(date.millisecondsSinceEpoch ~/ 1000)]);

    final results = await query.getSingleOrNull();

    return results != null;
  }

  Future<DayNote?> getDayNote(DateTime date) async {
    final query = customSelect(
        'SELECT * FROM day_notes '
        'WHERE date = ?',
        readsFrom: {dayNotes},
        variables: [Variable.withInt(date.millisecondsSinceEpoch ~/ 1000)]);

    final result = await query.getSingleOrNull();
    // Если результат запроса не null, преобразуем его в объект DayNote
    if (result != null) {
      return DayNote(
          id: result.read<int>('id'),
          owner_id: result.read<int>('owner_id'),
          date: DateTime.fromMillisecondsSinceEpoch(
              result.read<int>('date') * 1000),
          note: result.read<String>('note'));
    } else {
      return null;
    }
  }

  Future<Map<int, String>> getDayNotesForMonth(
      DateTime monthStart, DateTime monthEnd) async {
    final query = customSelect(
        'SELECT date, note FROM day_notes '
        'WHERE date >= ? AND date < ? '
        'ORDER BY date',
        readsFrom: {
          dayNotes
        },
        variables: [
          Variable.withDateTime(monthStart),
          Variable.withDateTime(monthEnd)
        ]);

    final result = await query.get();
    Map<int, String> notesByDay = {};
    for (var row in result) {
      final date = row.read<DateTime>('date');
      final note = row.read<String>('note');

      notesByDay.putIfAbsent(date.day, () => note);
    }

    return notesByDay;
  }
}
