import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  SymptomsBloc() : super(SymptomsSaved());


  Stream<SymptomsState> mapEventToState(SymptomsEvent event) async* {
    if (event is AddSymptoms) {
      // Логика добавления документа
      yield SymptomsSaved();
    } else if (event is UpdateSymptoms) {
      // Логика обновления документа
      yield SymptomsSaved();
    }
  }
}
