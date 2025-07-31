class SplitDay {
  final int splitDayId;
  final String dayName;
  final int routineId;
  final String dayExercisesDescription;

  SplitDay({
    required this.splitDayId,
    required this.dayName,
    required this.routineId,
    required this.dayExercisesDescription,
  });

  factory SplitDay.fromJson(Map<String, dynamic> json) => SplitDay(
    splitDayId: json['split_day_id'],
    dayName: json['day_name'],
    routineId: json['routine_id'],
    dayExercisesDescription: json['day_exercises_description'],
  );

  Map<String, dynamic> toJson() => {
    'split_day_id': splitDayId,
    'day_name': dayName,
    'routine_id': routineId,
    'day_exercises_description': dayExercisesDescription,
  };
}