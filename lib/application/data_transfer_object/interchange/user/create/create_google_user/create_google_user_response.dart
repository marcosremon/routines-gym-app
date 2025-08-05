import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateGoogleUserResponse extends BaseResponse {

  CreateGoogleUserResponse({
    super.isSuccess,
    super.message,
  });

  factory CreateGoogleUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateGoogleUserResponse(
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