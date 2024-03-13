class UserModel {
  final int id;
  final String username;
  final DateTime birthdate;
  final String deseaseHistory;
  final String threatmentHistory;

  UserModel({
    required this.id,
    required this.username,
    required this.birthdate,
    required this.deseaseHistory,
    required this.threatmentHistory,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      username: map['name'] as String,
      birthdate: DateTime.fromMillisecondsSinceEpoch(map['birthdate'] as int),
      deseaseHistory: map['deseaseHistory'] as String,
      threatmentHistory: map['threatmentHistory'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'birthdate': birthdate.toIso8601String(),
      'desease_history': deseaseHistory,
      'treatment_history': threatmentHistory,
    };
  }
}
