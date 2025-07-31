import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteRoutineResponse extends BaseResponse {
  int userId;

  DeleteRoutineResponse({
    required bool success,
    required String message,
    required this.userId,
  }) : super(isSuccess: success, message: message);

  factory DeleteRoutineResponse.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineResponse(
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
