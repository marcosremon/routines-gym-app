import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class ChangePasswordWithPasswordAndEmailResponse extends BaseResponseJson {
  int userId;

  ChangePasswordWithPasswordAndEmailResponse({
    required super.isSuccess,
    required String super.message,
    required this.userId,
  });

  factory ChangePasswordWithPasswordAndEmailResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordWithPasswordAndEmailResponse(
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
