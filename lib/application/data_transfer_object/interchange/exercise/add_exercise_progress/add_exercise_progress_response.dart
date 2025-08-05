import 'package:routines_gym_app/transversal/common/base_response.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class AddExerciseProgressResponse extends BaseResponse {

  AddExerciseProgressResponse({
    super.responseCode,
    super.isSuccess,
    super.message,
  });

  factory AddExerciseProgressResponse.fromJson(Map<String, dynamic> json) {
    return AddExerciseProgressResponse(
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