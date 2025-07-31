class DayInfoDTO {
  String? weekDay;
  String dayExercisesDescription;

  DayInfoDTO({
    this.weekDay,
    required this.dayExercisesDescription,
  });

  factory DayInfoDTO.fromJson(Map<String, dynamic> json) {
    return DayInfoDTO(
      weekDay: json['weekDay'],
      dayExercisesDescription: json['dayExercisesDescription'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekDay': weekDay,
      'dayExercisesDescription': dayExercisesDescription,
    };
  }
}
