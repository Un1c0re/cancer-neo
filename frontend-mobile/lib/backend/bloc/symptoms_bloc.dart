import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  SymptomsBloc() : super(SymptomsInitial()) {
    on<SymptomsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
