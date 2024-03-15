class DocSummary {
  final int id;
  final String docName;
  final DateTime docDate;

  DocSummary({
    required this.id,
    required this.docName,
    required this.docDate,
  });
}


class DocModel {
  final int id;
  final String docName;
  final DateTime docDate;
  final String docPlace;
  final String docNotes;

  DocModel({
    required this.id, 
    required this.docName, 
    required this.docDate, 
    required this.docPlace, 
    required this.docNotes,
  });

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id:       map['id'] as int,
      docName:  map['docName'] as String,
      docDate:  DateTime.fromMillisecondsSinceEpoch(map['docDate'] as int),
      docPlace: map['docPlace'] as String,
      docNotes: map['docNotes'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'docName': docName,
      'docDate': docDate,
      'docPlace': docPlace,
      'docNotes': docNotes,
    };
  }
}