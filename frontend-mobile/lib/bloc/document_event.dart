part of 'document_bloc.dart';

abstract class DocumentEvent {}

class DocumentFilterChanged extends DocumentEvent {
  final DateTime? date;

  DocumentFilterChanged({this.date});
}
