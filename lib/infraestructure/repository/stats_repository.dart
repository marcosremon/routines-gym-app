import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/get_stats/get_stats_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_response.dart';
import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/infraestructure/datasource/stats_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class StatsRepository {
  final StatsDatasource statsDatasource = StatsDatasource();

  Future<SaveDailyStepsResponse> saveDailySteps(SaveDailyStepsRequest setDailyStepsRequest) async 
  {
    SaveDailyStepsResponse setDailyStepsResponse = SaveDailyStepsResponse();
    try {
      Map<String, dynamic> data = await statsDatasource.saveDailySteps(setDailyStepsRequest);
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

  Future<GetStatsResponse> getStats() async 
  {
    GetStatsResponse getStatsResponse = GetStatsResponse();
    try {
      Map<String, dynamic> data = await statsDatasource.getStats();
      if (data['responseCodeJson'] == 200) {
        getStatsResponse.isSuccess = data['isSuccess'];
        getStatsResponse.message = data['message'];
        getStatsResponse.stats = (data['stats'] as List)
            .map((item) => Stats.fromJson(item))
            .toList();
      } else {
        getStatsResponse.isSuccess = false;
        getStatsResponse.message = 'Error: ${data['message']}';
        getStatsResponse.stats = [];
      }
      getStatsResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
      return getStatsResponse;
    } catch (ex) {
      getStatsResponse.isSuccess = false;
      getStatsResponse.message = 'Unexpected error on StatsRepository -> getStats';
    }
    return getStatsResponse;
  }
}