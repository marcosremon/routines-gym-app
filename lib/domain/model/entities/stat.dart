class Stats {
  final DateTime date;
  final int steps;

  Stats({required this.date, required this.steps});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      date: DateTime.parse(json['date']),
      steps: json['steps'] as int,
    );
  }
}