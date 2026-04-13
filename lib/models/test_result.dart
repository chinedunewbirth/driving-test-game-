class TestResult {
  final String testType;
  final int score;
  final int totalQuestions;
  final int passScore;
  final DateTime completedAt;
  final Duration timeTaken;

  TestResult({
    required this.testType,
    required this.score,
    required this.totalQuestions,
    required this.passScore,
    required this.timeTaken,
    DateTime? completedAt,
  }) : completedAt = completedAt ?? DateTime.now();

  bool get passed => score >= passScore;
  double get percentage =>
      totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;
}
