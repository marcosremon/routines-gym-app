import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class AddExerciseAddExerciseProgressResponse extends BaseResponse {
  UserDTO? userDTO;

  AddExerciseAddExerciseProgressResponse({
    this.userDTO,
    super.responseCode,
    super.isSuccess,
    super.message,
  });

  factory AddExerciseAddExerciseProgressResponse.fromJson(Map<String, dynamic> json) {
    return AddExerciseAddExerciseProgressResponse(
      userDTO: json['userDTO'] != null
          ? UserDTO.fromJson(json['userDTO'])
          : null,
      responseCode: json['responseCode'] != null
          ? ResponseCodes.fromValue(json['responseCode'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'userDTO': userDTO?.toJson(),
        'responseCode': responseCode?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}