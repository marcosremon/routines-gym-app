import 'package:routines_gym_app/transversal/common/base_response.dart';

class ChangePasswordWithPasswordAndEmailResponse extends BaseResponse {

  ChangePasswordWithPasswordAndEmailResponse({
    super.isSuccess,
    super.message,
  });

  factory ChangePasswordWithPasswordAndEmailResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordWithPasswordAndEmailResponse(
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
