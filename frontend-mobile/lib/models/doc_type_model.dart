class DocTypeModel {
  final int id;
  final String name;

  DocTypeModel({
    required this.id,
    required this.name,
  });

  factory DocTypeModel.fromMap(Map<String, dynamic> map) {
    return DocTypeModel(
      id:   map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}