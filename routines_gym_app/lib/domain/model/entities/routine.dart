class Routine {
  final int routineId;
  final String routineName;
  final String routineDescription;
  final int userId;

  Routine({
    required this.routineId,
    required this.routineName,
    required this.routineDescription,
    required this.userId,
  });

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    routineId: json['routine_id'],
    routineName: json['routine_name'],
    routineDescription: json['routine_description'],
    userId: json['user_id'],
  );

  Map<String, dynamic> toJson() => {
    'routine_id': routineId,
    'routine_name': routineName,
    'routine_description': routineDescription,
    'user_id': userId,
  };
}