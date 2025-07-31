import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetAllUserRoutinesResponseJson extends BaseResponseJson {
  List<RoutineDTO> routines;

  GetAllUserRoutinesResponseJson({
    required bool success,
    required String message,
    required this.routines,
  }) : super(isSuccess: success, message: message);

  factory GetAllUserRoutinesResponseJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserRoutinesResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      routines: (json['routines'] as List<dynamic>? ?? [])
          .map((e) => RoutineDTO.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['routines'] = routines.map((e) => e.toJson()).toList();
    return data;
  }
}
