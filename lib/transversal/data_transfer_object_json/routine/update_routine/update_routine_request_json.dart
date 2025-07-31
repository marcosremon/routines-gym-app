import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';

class UpdateRoutineRequestJson {
  int? routineId;
  String? routineName;
  String? routineDescription;
  List<SplitDayDTO> splitDays;

  UpdateRoutineRequestJson({
    this.routineId,
    this.routineName,
    this.routineDescription,
    required this.splitDays,
  });

  factory UpdateRoutineRequestJson.fromJson(Map<String, dynamic> json) {
    return UpdateRoutineRequestJson(
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
      routineName: json['routineName'],
      routineDescription: json['routineDescription'],
      splitDays: (json['splitDays'] as List<dynamic>? ?? [])
          .map((e) => SplitDayDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
      'routineName': routineName,
      'routineDescription': routineDescription,
      'splitDays': splitDays.map((e) => e.toJson()).toList(),
    };
  }
}
