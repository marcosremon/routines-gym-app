import 'package:routines_gym_app/transversal/common/response_codes.dart';

class BaseResponse {
  ResponseCodes? responseCode;
  bool? isSuccess;
  String? message;

  BaseResponse({
    this.responseCode,
    this.isSuccess = false,
    this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      responseCode: json['responseCodeJson'] != null
          ? ResponseCodes.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'responseCodeJson': responseCode?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}