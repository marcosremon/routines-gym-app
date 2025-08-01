import 'package:routines_gym_app/transversal/common/base_response.dart';

class ChangePasswordWithPasswordAndEmailResponse extends BaseResponse {
  int? userId;

  ChangePasswordWithPasswordAndEmailResponse({
    super.isSuccess,
    super.message,
    this.userId,
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
