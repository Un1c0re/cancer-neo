import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String name;
  final String place;
  final String notes;
  final DateTime date;
  final Uint8List pdfFile;
  
  const Document({
    required this.name,
    required this.place,
    required this.notes,
    required this.date,
    required this.pdfFile,
  }) : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}