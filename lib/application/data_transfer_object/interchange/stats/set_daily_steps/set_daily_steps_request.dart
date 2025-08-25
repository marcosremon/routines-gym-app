class SaveDailyStepsRequest {
  final int steps;
  String? userEmail;

  SaveDailyStepsRequest({
    required this.steps,
    this.userEmail,
  });
}
