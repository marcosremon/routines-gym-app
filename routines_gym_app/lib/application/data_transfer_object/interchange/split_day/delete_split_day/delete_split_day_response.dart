import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class DeleteSplitDayResponse extends BaseResponseJson {
  DeleteSplitDayResponse({
    required bool success,
    required String message,
  }) : super(isSuccess: success, message: message);

  factory DeleteSplitDayResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSplitDayResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
