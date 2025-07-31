import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetUserByEmailResponseJson extends BaseResponseJson {
  UserDTO? userDTO;
  int routinesCount;
  int friendsCount;

  GetUserByEmailResponseJson({
    required super.isSuccess,
    required String super.message,
    this.userDTO,
    required this.routinesCount,
    required this.friendsCount,
  });

  factory GetUserByEmailResponseJson.fromJson(Map<String, dynamic> json) {
    return GetUserByEmailResponseJson(
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
