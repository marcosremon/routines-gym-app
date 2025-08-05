import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';

class CreateRoutineRequest {
  String? userEmail;
  String? routineName;
  String? routineDescription;
  List<SplitDayDTO> splitDays;

  CreateRoutineRequest({
    this.userEmail,
    this.routineName,
    this.routineDescription,
    required this.splitDays,
  });

  factory CreateRoutineRequest.fromJson(Map<String, dynamic> json) {
    return CreateRoutineRequest(
      userEmail: json['userEmail'],
      routineName: json['routineName'],
      routineDescription: json['routineDescription'],
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
      'splitDays': splitDays.map((e) => e.toJson()).toList(),
    };
  }
}
