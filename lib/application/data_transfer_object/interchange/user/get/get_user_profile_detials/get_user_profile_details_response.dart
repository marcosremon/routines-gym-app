import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetUserProfileDetilesResponse extends BaseResponse {
  String? username;
  DateTime? inscriptionDate;
  int? routineCount;

  GetUserProfileDetilesResponse({
    this.username,
    this.inscriptionDate,
    this.routineCount,
  });
}