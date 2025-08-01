import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetRoutineByIdResponse extends BaseResponse {
  RoutineDTO? routineDTO;

  GetRoutineByIdResponse({
    success,
    message,
    this.routineDTO,
  }) : super(isSuccess: success);

  factory GetRoutineByIdResponse.fromJson(Map<String, dynamic> json) {
    return GetRoutineByIdResponse(
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
