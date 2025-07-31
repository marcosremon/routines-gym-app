import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetRoutineByIdResponseJson extends BaseResponseJson {
  RoutineDTO? routineDTO;

  GetRoutineByIdResponseJson({
    required bool success,
    required String message,
    this.routineDTO,
  }) : super(isSuccess: success, message: message);

  factory GetRoutineByIdResponseJson.fromJson(Map<String, dynamic> json) {
    return GetRoutineByIdResponseJson(
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
