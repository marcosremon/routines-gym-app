import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteUserResponse extends BaseResponse {
  int userId;

  DeleteUserResponse({
    required super.isSuccess,
    required String super.message,
    required this.userId,
  });

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(
      isSuccess: json['isSuccess'] ?? false,
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
