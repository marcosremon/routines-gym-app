class SetDailyStepsRequest {
  final int steps;
  final int limitStepsPerDay;
  final DateTime date;

  SetDailyStepsRequest({required this.steps, required this.limitStepsPerDay, required this.date});
}