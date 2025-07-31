class DeleteRoutineRequestJson {
  String? userEmail;
  int? routineId;

  DeleteRoutineRequestJson({
    this.userEmail,
    this.routineId,
  });

  factory DeleteRoutineRequestJson.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineRequestJson(
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
