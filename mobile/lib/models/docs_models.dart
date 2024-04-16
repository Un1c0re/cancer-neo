import 'dart:typed_data';

class DocModel {
  final int id;
  final String name;
  final int type_id;
  final DateTime date;
  final String place;
  final String notes;
  final Uint8List? file;

  DocModel({
    required this.id, 
    required this.name, 
    required this.type_id, 
    required this.date, 
    required this.place, 
    required this.notes,
    required this.file,
  });

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id:       map['id'] as int,
      name:  map['name'] as String,
      type_id:  map['type_id'] as int,
      date:  DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      place: map['place'] as String,
      notes: map['notes'] as String,
      file: map['file'] as Uint8List?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type_id': type_id,
      'date': date,
      'place': place,
      'notes': notes,
      'file': file,
    };
  }
}