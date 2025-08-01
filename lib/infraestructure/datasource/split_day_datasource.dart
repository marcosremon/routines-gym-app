import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/delete_split_day/delete_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/delete_split_day/delete_split_day_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class SplitDayDatasource {
  final Dio dio = Dio();

  Future<UpdateSplitDayResponse> updateSplitDay(UpdateSplitDayRequest updateSplitDayRequest) async {
    UpdateSplitDayResponse updateSplitDayResponse = UpdateSplitDayResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/update-split-day',
        data: {
          'routineId': updateSplitDayRequest.routineId,
          'userEmail': updateSplitDayRequest.userEmail,
          'addDays': updateSplitDayRequest.addDays,
          'deleteDays': updateSplitDayRequest.deleteDays,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        updateSplitDayResponse.isSuccess = data['isSuccess'];
        updateSplitDayResponse.message = data['message'];
        updateSplitDayResponse.userDTO = data['userDTO'];
      } else {
        updateSplitDayResponse.isSuccess = false;
        updateSplitDayResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      updateSplitDayResponse.isSuccess = false;
      updateSplitDayResponse.message = 'unexpected error on SplitDayDatasource -> updateSplitDay: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return updateSplitDayResponse;
  }

  Future<DeleteSplitDayResponse> deleteSplitDay(DeleteSplitDayRequest deleteSplitDayRequest) async {
    DeleteSplitDayResponse deleteSplitDayResponse = DeleteSplitDayResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/delete-split-day',
        data: {
          'dayName': deleteSplitDayRequest.dayName,
          'routineId': deleteSplitDayRequest.routineId,
          'userId': deleteSplitDayRequest.userId,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        deleteSplitDayResponse.isSuccess = data['isSuccess'];
        deleteSplitDayResponse.message = data['message'];
      } else {
        deleteSplitDayResponse.isSuccess = false;
        deleteSplitDayResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      deleteSplitDayResponse.isSuccess = false;
      deleteSplitDayResponse.message = 'unexpected error on SplitDayDatasource -> deleteSplitDay: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return deleteSplitDayResponse;
  }
}