import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetStatsResponse extends BaseResponse {
  List<Stats>? stats;

  GetStatsResponse({
    this.stats,
    super.message,
    bool super.isSuccess = true,
  });
}