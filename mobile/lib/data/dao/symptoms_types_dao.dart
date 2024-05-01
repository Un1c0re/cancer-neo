part of 'package:cancerneo/data/moor_db.dart';

@UseDao(tables: [Users, SymptomsTypes, SymptomsNames, SymptomsValues])
class SymptomsTypesDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsTypesDaoMixin {
  final AppDatabase db;

  SymptomsTypesDao(this.db) : super(db);

  Future<void> initSymptomsTypes() async {
    final query = select(symptomsTypes)..limit(1);
    final List<SymptomsType> types = await query.get();
    final bool doTypesExist = types.isNotEmpty;

    if(doTypesExist) return;

    List<String> symptomsTypesList = dotenv.env['SYMPTOMS_TYPES']!.split(',');
      for(int i = 0; i < symptomsTypesList.length; i++) {
        await into(symptomsTypes)
          .insert(SymptomsTypesCompanion.insert(name: symptomsTypesList[i]));
    }
  }

  Future<List<SymptomTypeModel>> getSymptomTypes() async {
    final query = customSelect(
      'SELECT * FROM symptoms_types',
      readsFrom: {symptomsTypes},
    );

    final results = await query.get();
    List<SymptomTypeModel> symptomsTypesList = results.map((row)=>SymptomTypeModel(
      id: row.read<int>('id'), 
      name: row.read<String>('name'),
      )).toList();

    return symptomsTypesList;
  }
}
