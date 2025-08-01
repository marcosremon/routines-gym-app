import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteSplitDayResponse extends BaseResponse {
  DeleteSplitDayResponse({
    success,
    message,
  }) : super(isSuccess: success);

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
