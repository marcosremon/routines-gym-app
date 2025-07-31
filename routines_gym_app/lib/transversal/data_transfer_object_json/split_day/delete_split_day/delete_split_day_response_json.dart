import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class DeleteSplitDayResponseJson extends BaseResponseJson {
  DeleteSplitDayResponseJson({
    required bool success,
    required String message,
  }) : super(isSuccess: success, message: message);

  factory DeleteSplitDayResponseJson.fromJson(Map<String, dynamic> json) {
    return DeleteSplitDayResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
