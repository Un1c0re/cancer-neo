class SymptomTypeModel {
  final int id;
  final String name;

  SymptomTypeModel({
    required this.id,
    required this.name,
  });

  factory SymptomTypeModel.fromMap(Map<String, dynamic> map) {
    return SymptomTypeModel(
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