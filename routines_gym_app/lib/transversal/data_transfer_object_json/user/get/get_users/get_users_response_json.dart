import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetUsersResponseJson extends BaseResponseJson {
  List<UserDTO>? usersDTO;

  GetUsersResponseJson({
    required super.isSuccess,
    required String super.message,
    this.usersDTO,
  });

  factory GetUsersResponseJson.fromJson(Map<String, dynamic> json) {
    return GetUsersResponseJson(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      usersDTO: json['usersDTO'] != null
          ? (json['usersDTO'] as List)
              .map((e) => UserDTO.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (usersDTO != null) {
      data['usersDTO'] = usersDTO!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
