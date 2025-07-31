import 'package:routines_gym_app/transversal/common/base_response_json.dart';
import 'package:routines_gym_app/transversal/common/response_codes_json.dart';

class LoginResponse extends BaseResponseJson {
  String bearerToken;
  bool isAdmin;

  LoginResponse({
    this.bearerToken = '',
    required this.isAdmin,
    ResponseCodesJson? responseCodeJson,
    bool isSuccess = false,
    String? message,
  }) : super(
          responseCodeJson: responseCodeJson,
          isSuccess: isSuccess,
          message: message,
        );

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      bearerToken: json['bearerToken'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      responseCodeJson: json['responseCodeJson'] != null
          ? ResponseCodesJson.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'bearerToken': bearerToken,
        'isAdmin': isAdmin,
        'responseCodeJson': responseCodeJson?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}