import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateUserResponse extends BaseResponse {

  CreateUserResponse({
    super.isSuccess,
    super.message,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    return data;
  }
}
