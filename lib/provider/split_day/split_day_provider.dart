import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_response.dart';
import 'package:routines_gym_app/infraestructure/repository/split_day_repository.dart';

class SplitDayProvider extends ChangeNotifier {
  final SplitDayRepository splitDayRepository = SplitDayRepository();
  
  Future<UpdateSplitDayResponse> updateSplitDay(UpdateSplitDayRequest updateSplitDayRequest) async 
  {
    return await splitDayRepository.updateSplitDay(updateSplitDayRequest);
  }
}