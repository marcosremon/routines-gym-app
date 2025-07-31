import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class UpdateUserResponseJson extends BaseResponse {
  UserDTO? userDTO;

  UpdateUserResponseJson({
    required super.isSuccess,
    required String super.message,
    this.userDTO,
  });

  factory UpdateUserResponseJson.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponseJson(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      userDTO: json['userDTO'] != null ? UserDTO.fromJson(json['userDTO']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (userDTO != null) {
      data['userDTO'] = userDTO!.toJson();
    }
    return data;
  }
}
