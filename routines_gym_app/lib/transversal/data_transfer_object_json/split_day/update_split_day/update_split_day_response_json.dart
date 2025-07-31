import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class UpdateSplitDayResponseJson extends BaseResponseJson {
  UserDTO? userDTO;

  UpdateSplitDayResponseJson({
    required bool success,
    required String message,
    this.userDTO,
  }) : super(isSuccess: success, message: message);

  factory UpdateSplitDayResponseJson.fromJson(Map<String, dynamic> json) {
    return UpdateSplitDayResponseJson(
      success: json['success'] ?? false,
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
