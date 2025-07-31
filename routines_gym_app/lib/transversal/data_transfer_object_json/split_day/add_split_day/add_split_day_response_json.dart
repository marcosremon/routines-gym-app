import 'package:routines_gym_app/application/data_transfer_object/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class AddSplitDayResponseJson extends BaseResponseJson {
  UserDTO? userDTO;

  AddSplitDayResponseJson({
    required bool success,
    required String message,
    this.userDTO,
  }) : super(isSuccess: success, message: message);

  factory AddSplitDayResponseJson.fromJson(Map<String, dynamic> json) {
    return AddSplitDayResponseJson(
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
