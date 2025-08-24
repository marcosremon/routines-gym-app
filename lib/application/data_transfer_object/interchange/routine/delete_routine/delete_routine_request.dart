class DeleteRoutineRequest {
  String? userEmail;
  String? routineName;

  DeleteRoutineRequest({
    this.userEmail,
    this.routineName,
  });

  factory DeleteRoutineRequest.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineRequest(
      userEmail: json['userEmail'],
      routineName: json['routineName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'routineName': routineName,
    };
  }
}
