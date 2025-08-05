import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteUserResponse extends BaseResponse {

  DeleteUserResponse({
    super.isSuccess,
    super.message,
  });

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(
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
