import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetAllUserRoutinesResponse extends BaseResponse {
  List<RoutineDTO>? routines;

  GetAllUserRoutinesResponse({
    success,
    message,
    this.routines,
  }) : super(isSuccess: success);
}
