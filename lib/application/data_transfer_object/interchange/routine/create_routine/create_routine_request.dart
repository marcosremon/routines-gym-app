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
      userEmail: json['UserEmail'],
      routineName: json['RoutineName'],
      routineDescription: json['RoutineDescription'],
      splitDays: (json['SplitDays'] as List<dynamic>? ?? [])
          .map((e) => SplitDayDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserEmail': userEmail,
      'RoutineName': routineName,
      'RoutineDescription': routineDescription,
      'SplitDays': splitDays.map((e) => e.toJson()).toList(),
    };
  }
}