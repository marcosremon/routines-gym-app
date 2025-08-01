import 'package:routines_gym_app/transversal/common/base_response.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class LoginResponse extends BaseResponse {
  String bearerToken;
  bool? isAdmin;

  LoginResponse({
    this.bearerToken = '',
    this.isAdmin,
    super.responseCode,
    super.isSuccess,
    super.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      bearerToken: json['bearerToken'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      responseCode: json['responseCode'] != null
          ? ResponseCodes.fromValue(json['responseCode'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'bearerToken': bearerToken,
        'isAdmin': isAdmin,
        'responseCode': responseCode?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}