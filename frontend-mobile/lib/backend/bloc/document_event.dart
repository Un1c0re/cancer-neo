part of 'document_bloc.dart';



@immutable
abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}


class AddDocument extends DocumentEvent {
  final String name;
  final String place;
  final String notes;
  final DateTime date;
  final Uint8List pdfFile;

  const AddDocument(
    this.name, 
    this.date, 
    this.pdfFile, 
    this.place, 
    this.notes,
  );

  @override
  List<Object> get props => [
    name, 
    place, 
    notes, 
    date, 
    pdfFile,
  ];
}


class UpdateDocument extends DocumentEvent {
  final String documentId;
  final String newName;
  final String newPlace;
  final String newNotes;
  final DateTime newDate;
  final Uint8List newPdfFile;

  const UpdateDocument(
    this.documentId, 
    this.newName, 
    this.newDate, 
    this.newPdfFile, 
    this.newPlace, 
    this.newNotes,
  );
  
  @override
  List<Object> get props => [
    documentId, 
    newName,
    newDate,
    newNotes,
    newPdfFile,
  ];
}


class DeleteDocument extends DocumentEvent {
  final String documentId;

  const DeleteDocument(this.documentId);
  
  @override
  List<Object> get props => [documentId];
}
