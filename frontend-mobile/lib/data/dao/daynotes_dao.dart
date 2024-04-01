part of 'package:diplom/data/moor_db.dart'; 

@UseDao(tables: [Users, DayNotes])
class DayNotesDao extends DatabaseAccessor<AppDatabase> with _$DayNotesDaoMixin {
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

  Future<bool>ifDayNoteExists(DateTime date) async {
    final queryResults = await select(dayNotes).getSingleOrNull();
    return queryResults != null;
  }

  Future<DayNote?> getDayNote(DateTime date) async {
    final query = select(dayNotes)
    ..where((tbl) => tbl.date.equals(date));
    return query.getSingleOrNull();
  }
}
