class HazardClip {
  final String id;
  final String title;
  final String description;
  final String scenarioType;
  final List<HazardEvent> hazards;
  final int durationSeconds;

  const HazardClip({
    required this.id,
    required this.title,
    required this.description,
    required this.scenarioType,
    required this.hazards,
    required this.durationSeconds,
  });
}

class HazardEvent {
  final double appearTimeSeconds;
  final double deadlineSeconds;
  final String description;
  final double positionX;
  final double positionY;

  const HazardEvent({
    required this.appearTimeSeconds,
    required this.deadlineSeconds,
    required this.description,
    required this.positionX,
    required this.positionY,
  });

  int scoreForResponseTime(double responseTime) {
    if (responseTime < appearTimeSeconds) return 0;
    if (responseTime > deadlineSeconds) return 0;

    final window = deadlineSeconds - appearTimeSeconds;
    final elapsed = responseTime - appearTimeSeconds;
    final fraction = elapsed / window;

    if (fraction <= 0.2) return 5;
    if (fraction <= 0.4) return 4;
    if (fraction <= 0.6) return 3;
    if (fraction <= 0.8) return 2;
    return 1;
  }
}
