import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class DeleteRoutineResponseJson extends BaseResponseJson {
  int userId;

  DeleteRoutineResponseJson({
    required bool success,
    required String message,
    required this.userId,
  }) : super(isSuccess: success, message: message);

  factory DeleteRoutineResponseJson.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['userId'] = userId;
    return data;
  }
}
