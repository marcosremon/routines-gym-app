import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/stats_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class StatsRepository {
  final StatsDatasource statsDatasource = StatsDatasource();

  Future<SetDailyStepsResponse> setDailySteps(SetDailyStepsRequest setDailyStepsRequest) async 
  {
    SetDailyStepsResponse setDailyStepsResponse = SetDailyStepsResponse();
    try {
      Map<String, dynamic> data = await statsDatasource.setDailySteps(setDailyStepsRequest);
      if (data['responseCodeJson'] == 200) {
        setDailyStepsResponse.isSuccess = data['isSuccess'];
        setDailyStepsResponse.message = data['message'];
      } else {
        setDailyStepsResponse.isSuccess = false;
        setDailyStepsResponse.message = 'Error: ${data['message']}';
      }
      setDailyStepsResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      setDailyStepsResponse.isSuccess = false;
      setDailyStepsResponse.message = 'Unexpected error on StatsRepository -> setDailySteps';
    }
    return setDailyStepsResponse;
  }
}