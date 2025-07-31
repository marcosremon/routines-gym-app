import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateNewPasswordResponse extends BaseResponse {
  int userId;

  CreateNewPasswordResponse({
    required super.isSuccess,
    required String super.message,
    required this.userId,
  });

  factory CreateNewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordResponse(
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
