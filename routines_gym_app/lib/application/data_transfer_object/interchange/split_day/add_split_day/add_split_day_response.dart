import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class AddSplitDayResponse extends BaseResponseJson {
  UserDTO? userDTO;

  AddSplitDayResponse({
    required bool success,
    required String message,
    this.userDTO,
  }) : super(isSuccess: success, message: message);

  factory AddSplitDayResponse.fromJson(Map<String, dynamic> json) {
    return AddSplitDayResponse(
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
