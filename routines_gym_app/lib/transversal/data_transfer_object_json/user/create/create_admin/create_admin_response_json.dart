import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class CreateAdminResponseJson extends BaseResponseJson {
  CreateAdminResponseJson({
    required super.isSuccess,
    required String super.message,
  });

  factory CreateAdminResponseJson.fromJson(Map<String, dynamic> json) {
    return CreateAdminResponseJson(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
