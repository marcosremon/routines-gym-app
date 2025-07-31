import 'package:routines_gym_app/transversal/common/base_response.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class CheckTokenStatusResponse extends BaseResponse {
  bool isValid;

  CheckTokenStatusResponse({
    this.isValid = false,
    super.responseCode,
    super.isSuccess,
    super.message,
  });

  factory CheckTokenStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckTokenStatusResponse(
      isValid: json['isValid'] ?? false,
      responseCode: json['responseCode'] != null
          ? ResponseCodes.fromValue(json['responseCode'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'responseCode': responseCode?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}