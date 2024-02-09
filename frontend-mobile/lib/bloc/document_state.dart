part of 'document_bloc.dart';

abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

class DocumentFiltered extends DocumentState {
  final List<Document> filteredDocuments;

  DocumentFiltered(this.filteredDocuments);
}