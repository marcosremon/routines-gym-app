import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';

class CreateRoutineRequestJson {
  String? userEmail;
  String? routineName;
  String? routineDescription;
  int sets;
  int reps;
  double weight;
  List<SplitDayDTO> splitDays;

  CreateRoutineRequestJson({
    this.userEmail,
    this.routineName,
    this.routineDescription,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.splitDays,
  });

  factory CreateRoutineRequestJson.fromJson(Map<String, dynamic> json) {
    return CreateRoutineRequestJson(
      userEmail: json['userEmail'],
      routineName: json['routineName'],
      routineDescription: json['routineDescription'],
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      weight: (json['weight'] != null) ? (json['weight'] as num).toDouble() : 0.0,
      splitDays: (json['splitDays'] as List<dynamic>? ?? [])
          .map((e) => SplitDayDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'routineName': routineName,
      'routineDescription': routineDescription,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'splitDays': splitDays.map((e) => e.toJson()).toList(),
    };
  }
}
