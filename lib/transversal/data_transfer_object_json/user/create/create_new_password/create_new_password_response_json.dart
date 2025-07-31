import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class CreateNewPasswordResponseJson extends BaseResponseJson {
  int userId;

  CreateNewPasswordResponseJson({
    required super.isSuccess,
    required String super.message,
    required this.userId,
  });

  factory CreateNewPasswordResponseJson.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordResponseJson(
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
