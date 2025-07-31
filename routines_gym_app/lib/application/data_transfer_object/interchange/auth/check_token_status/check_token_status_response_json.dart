import 'package:routines_gym_app/transversal/common/base_response_json.dart';
import 'package:routines_gym_app/transversal/common/response_codes_json.dart';

class CheckTokenStatusResponse extends BaseResponseJson {
  bool isValid;

  CheckTokenStatusResponse({
    this.isValid = false,
    ResponseCodesJson? responseCodeJson,
    bool isSuccess = false,
    String? message,
  }) : super(
          responseCodeJson: responseCodeJson,
          isSuccess: isSuccess,
          message: message,
        );

  factory CheckTokenStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckTokenStatusResponse(
      isValid: json['isValid'] ?? false,
      responseCodeJson: json['responseCodeJson'] != null
          ? ResponseCodesJson.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'responseCodeJson': responseCodeJson?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}