class UserModel {
  String fullName;
  String email;
  String level;
  DateTime? dateOfBirth;
  int? age;

  UserModel({
    required this.fullName,
    required this.email,
    this.level = 'Beginner',
    this.dateOfBirth,
    this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'level': level,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'age': age,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      level: json['level'] ?? 'Beginner',
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth']) 
          : null,
      age: json['age'],
    );
  }

  void calculateAge() {
    if (dateOfBirth != null) {
      final now = DateTime.now();
      age = now.year - dateOfBirth!.year;
      if (now.month < dateOfBirth!.month ||
          (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
        age = age! - 1;
      }
    }
  }
}