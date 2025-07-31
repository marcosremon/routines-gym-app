import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class CreateRoutineResponseJson extends BaseResponseJson {
  RoutineDTO? routineDTO;

  CreateRoutineResponseJson({
    required bool success,
    required String message,
    this.routineDTO,
  }) : super(isSuccess: success, message: message);

  factory CreateRoutineResponseJson.fromJson(Map<String, dynamic> json) {
    return CreateRoutineResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      routineDTO: json['routineDTO'] != null
          ? RoutineDTO.fromJson(json['routineDTO'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (routineDTO != null) {
      data['routineDTO'] = routineDTO!.toJson();
    }
    return data;
  }
}
