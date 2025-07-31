import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetUsersResponse extends BaseResponse {
  List<UserDTO>? usersDTO;

  GetUsersResponse({
    required super.isSuccess,
    required String super.message,
    this.usersDTO,
  });

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) {
    return GetUsersResponse(
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
