import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';

class RoutineDTO {
  String routineName;
  String routineDescription;
  int userId;
  List<SplitDayDTO> splitDays;

  RoutineDTO({
    required this.routineName,
    required this.routineDescription,
    required this.userId,
    required this.splitDays,
  });

  factory RoutineDTO.fromJson(Map<String, dynamic> json) {
    return RoutineDTO(
      routineName: json['routineName'] ?? '', 
      routineDescription: json['routineDescription'] ?? '', 
      userId: json['userId'] ?? 0, 
      splitDays: (json['splitDays'] as List<dynamic>? ?? [])
          .map((e) => SplitDayDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineName': routineName,
      'routineDescription': routineDescription,
      'userId': userId,
      'splitDays': splitDays.map((e) => e.toJson()).toList(),
    };
  }
}