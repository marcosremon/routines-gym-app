class DeleteRoutineRequest {
  String? userEmail;
  int? routineId;

  DeleteRoutineRequest({
    this.userEmail,
    this.routineId,
  });

  factory DeleteRoutineRequest.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineRequest(
      userEmail: json['userEmail'],
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'routineId': routineId,
    };
  }
}
