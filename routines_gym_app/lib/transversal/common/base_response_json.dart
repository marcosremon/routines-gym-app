import 'response_codes_json.dart';

class BaseResponseJson {
  ResponseCodesJson? responseCodeJson;
  bool isSuccess;
  String? message;

  BaseResponseJson({
    this.responseCodeJson,
    this.isSuccess = false,
    this.message,
  });

  factory BaseResponseJson.fromJson(Map<String, dynamic> json) {
    return BaseResponseJson(
      responseCodeJson: json['responseCodeJson'] != null
          ? ResponseCodesJson.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'responseCodeJson': responseCodeJson?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}