import 'package:routines_gym_app/transversal/common/base_response.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class DeleteExerciseResponse extends BaseResponse {

  DeleteExerciseResponse({
    super.responseCode,
    super.isSuccess,
    super.message,
  });

  factory DeleteExerciseResponse.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseResponse(
      responseCode: json['responseCode'] != null
          ? ResponseCodes.fromValue(json['responseCode'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'responseCode': responseCode?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}