import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(DocumentSaved());

  Stream<DocumentState> mapEventToState(DocumentEvent event) async* {
    if (event is AddDocument) {
      // Логика добавления документа
      yield DocumentSaved();
    } else if (event is UpdateDocument) {
      // Логика обновления документа
      yield DocumentSaved();
    } else if (event is DeleteDocument) {
      // Логика удаления документа
      yield DocumentSaved();
    }
  }
}
