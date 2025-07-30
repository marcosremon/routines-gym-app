import 'package:routines_gym_app/transversal/common/base_response_json.dart';
import 'package:routines_gym_app/transversal/common/response_codes_json.dart';
import 'package:routines_gym_app/application/data_transfer_object/entity/user_dto.dart';

class DeleteExerciseResponseJson extends BaseResponseJson {
  UserDTO? userDTO;

  DeleteExerciseResponseJson({
    this.userDTO,
    ResponseCodesJson? responseCodeJson,
    bool isSuccess = false,
    String? message,
  }) : super(
          responseCodeJson: responseCodeJson,
          isSuccess: isSuccess,
          message: message,
        );

  factory DeleteExerciseResponseJson.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseResponseJson(
      userDTO: json['userDTO'] != null
          ? UserDTO.fromJson(json['userDTO'])
          : null,
      responseCodeJson: json['responseCodeJson'] != null
          ? ResponseCodesJson.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'userDTO': userDTO?.toJson(),
        'responseCodeJson': responseCodeJson?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}