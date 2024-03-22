part of 'package:diplom/data/moor_db.dart'; 

@UseDao(tables: [Users, DayNotes])
class DayNotesDao extends DatabaseAccessor<AppDatabase> with _$DayNotesDaoMixin {
  final AppDatabase db;

  DayNotesDao(this.db) : super(db);

  Future<void> addDayNote({
    required int ownerId,
    required DateTime date,
    required String note,
  }) async {
    final dayNoteEntry = DayNotesCompanion.insert(
      owner_id: ownerId,
      date: date,
      note: note,
    );
    await into(dayNotes).insert(dayNoteEntry);
  }

  Future<void> updateDayNote({
    required int id,
    String? note,
    DateTime? date,
  }) async {
    final dayNoteEntry = DayNotesCompanion(
      id: Value(id),
      note: note != null ? Value(note) : const Value.absent(),
      date: date != null ? Value(date) : const Value.absent(),
    );
    await (update(dayNotes)..where((tbl) => tbl.id.equals(id)))
        .write(dayNoteEntry);
  }
}
