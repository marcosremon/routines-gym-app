import 'package:routines_gym_app/application/data_transfer_object/split_day_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetAllUserSplitsResponseJson extends BaseResponseJson {
  List<SplitDayDTO> splitDays;

  GetAllUserSplitsResponseJson({
    required bool success,
    required String message,
    required this.splitDays,
  }) : super(isSuccess: success, message: message);

  factory GetAllUserSplitsResponseJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserSplitsResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      splitDays: (json['splitDays'] as List<dynamic>? ?? [])
          .map((e) => SplitDayDTO.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['splitDays'] = splitDays.map((e) => e.toJson()).toList();
    return data;
  }
}
