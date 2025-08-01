import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetUserByEmailResponse extends BaseResponse {
  UserDTO? userDTO;
  int? routinesCount;
  int? friendsCount;

  GetUserByEmailResponse({
    super.isSuccess,
    super.message,
    this.userDTO,
    this.routinesCount,
    this.friendsCount,
  });

  factory GetUserByEmailResponse.fromJson(Map<String, dynamic> json) {
    return GetUserByEmailResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      userDTO: json['userDTO'] != null ? UserDTO.fromJson(json['userDTO']) : null,
      routinesCount: json['routinesCount'] ?? 0,
      friendsCount: json['friendsCount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (userDTO != null) {
      data['userDTO'] = userDTO!.toJson();
    }
    data['routinesCount'] = routinesCount;
    data['friendsCount'] = friendsCount;
    return data;
  }
}
