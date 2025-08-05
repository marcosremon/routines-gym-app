import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateNewPasswordResponse extends BaseResponse {

  CreateNewPasswordResponse({
    super.isSuccess,
    super.message,
  });

  factory CreateNewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordResponse(
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
