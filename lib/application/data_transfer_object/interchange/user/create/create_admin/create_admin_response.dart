import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateAdminResponse extends BaseResponse {
  CreateAdminResponse({
    required super.isSuccess,
    required String super.message,
  });

  factory CreateAdminResponse.fromJson(Map<String, dynamic> json) {
    return CreateAdminResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
