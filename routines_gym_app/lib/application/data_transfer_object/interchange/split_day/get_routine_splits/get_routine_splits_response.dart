import 'package:routines_gym_app/application/data_transfer_object/entities/day_info_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetRoutineSplitsResponse extends BaseResponseJson {
  List<DayInfoDTO> dayInfo;

  GetRoutineSplitsResponse({
    required bool success,
    required String message,
    required this.dayInfo,
  }) : super(isSuccess: success, message: message);

  factory GetRoutineSplitsResponse.fromJson(Map<String, dynamic> json) {
    return GetRoutineSplitsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      dayInfo: (json['dayInfo'] as List<dynamic>? ?? [])
          .map((e) => DayInfoDTO.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['dayInfo'] = dayInfo.map((e) => e.toJson()).toList();
    return data;
  }
}
