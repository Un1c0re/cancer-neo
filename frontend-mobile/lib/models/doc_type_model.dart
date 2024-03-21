class DoctypeModel {
  final int id;
  final String name;

  DoctypeModel({
    required this.id,
    required this.name,
  });

  factory DoctypeModel.fromMap(Map<String, dynamic> map) {
    return DoctypeModel(
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