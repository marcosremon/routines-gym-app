import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateGoogleUserResponse extends BaseResponse {
  UserDTO? userDTO;

  CreateGoogleUserResponse({
    super.isSuccess,
    super.message,
    this.userDTO,
  });

  factory CreateGoogleUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateGoogleUserResponse(
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
