import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/delete_split_day/delete_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class SplitDayDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> updateSplitDay(UpdateSplitDayRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/update-split-day',
        data: {
          'routineId': request.routineId,
          'userEmail': request.userEmail,
          'addDays': request.addDays,
          'deleteDays': request.deleteDays,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> deleteSplitDay(DeleteSplitDayRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/delete-split-day',
        data: {
          'dayName': request.dayName,
          'routineId': request.routineId,
          'userId': request.userId,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }
}