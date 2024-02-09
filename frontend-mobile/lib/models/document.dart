class Document {
  final String id;
  final String title;
  final DateTime date;
  final String place;
  final dynamic file;

  Document({
    required this.id, 
    required this.title, 
    required this.date,
    required this.place,
    required this.file,
  });
}