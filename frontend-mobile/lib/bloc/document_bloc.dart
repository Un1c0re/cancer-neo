import 'package:bloc/bloc.dart';

import '../models/document.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final List<Document> _allDocuments; // Исходный список документов

  DocumentBloc(this._allDocuments) : super(DocumentInitial()) {
    on<DocumentFilterChanged>(_onDocumentFilterChanged);
  }

  void _onDocumentFilterChanged(DocumentFilterChanged event, Emitter<DocumentState> emit) {
    if (event.date == null) {
      emit(DocumentFiltered(_allDocuments));
    } else {
      final filteredDocuments = _allDocuments.where((doc) => doc.date.isAfter(event.date!)).toList();
      emit(DocumentFiltered(filteredDocuments));
    }
  }
}
