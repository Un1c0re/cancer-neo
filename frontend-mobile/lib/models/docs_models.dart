class DocModel {
  final int id;
  final String docName;
  final int docType;
  final DateTime docDate;
  final String docPlace;
  final String docNotes;

  DocModel({
    required this.id, 
    required this.docName, 
    required this.docType, 
    required this.docDate, 
    required this.docPlace, 
    required this.docNotes,
  });

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id:       map['id'] as int,
      docName:  map['docName'] as String,
      docType:  map['docType'] as int,
      docDate:  DateTime.fromMillisecondsSinceEpoch(map['docDate'] as int),
      docPlace: map['docPlace'] as String,
      docNotes: map['docNotes'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'docName': docName,
      'docType': docType,
      'docDate': docDate,
      'docPlace': docPlace,
      'docNotes': docNotes,
    };
  }
}