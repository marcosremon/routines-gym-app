import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/split_day_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class SplitDayRepository {
  final SplitDayDatasource splitDayDatasource = SplitDayDatasource();

  Future<UpdateSplitDayResponse> updateSplitDay(UpdateSplitDayRequest updateSplitDayRequest) async 
  {
    UpdateSplitDayResponse updateSplitDayResponse = UpdateSplitDayResponse();
    try {
      Map<String, dynamic> data = await splitDayDatasource.updateSplitDay(updateSplitDayRequest);
      if (data['responseCodeJson'] == 200) {
        updateSplitDayResponse.isSuccess = data['isSuccess'];
        updateSplitDayResponse.message = data['message'];
        updateSplitDayResponse.userDTO = UserDTO.fromJson(data['userDTO']);
      } else {
        updateSplitDayResponse.isSuccess = false;
        updateSplitDayResponse.message = 'Error: ${data['message']}';
      }
      updateSplitDayResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      updateSplitDayResponse.isSuccess = false;
      updateSplitDayResponse.message = 'Unexpected error on SplitDayRepository -> updateSplitDay';
    }
    return updateSplitDayResponse;
  }
}