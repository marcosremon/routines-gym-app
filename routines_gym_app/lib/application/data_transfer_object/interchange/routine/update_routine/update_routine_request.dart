import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';

class UpdateRoutineRequest {
  int? routineId;
  String? routineName;
  String? routineDescription;
  List<SplitDayDTO> splitDays;

  UpdateRoutineRequest({
    this.routineId,
    this.routineName,
    this.routineDescription,
    required this.splitDays,
  });

  factory UpdateRoutineRequest.fromJson(Map<String, dynamic> json) {
    return UpdateRoutineRequest(
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
