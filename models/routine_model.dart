class RoutineModel {
  String id;
  String name;
  String description;
  String time;
  String creator;
  List<String> activities;

  RoutineModel({
    required this.id,
    required this.name,
    required this.description,
    required this.time,
    this.creator = 'Creator',
    this.activities = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'time': time,
      'creator': creator,
      'activities': activities,
    };
  }

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      time: json['time'],
      creator: json['creator'] ?? 'Creator',
      activities: List<String>.from(json['activities'] ?? []),
    );
  }
}