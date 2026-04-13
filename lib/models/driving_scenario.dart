class DrivingScenario {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final List<ScenarioStep> steps;

  const DrivingScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.steps,
  });
}

class ScenarioStep {
  final String narrative;
  final String situation;
  final List<ScenarioChoice> choices;

  const ScenarioStep({
    required this.narrative,
    required this.situation,
    required this.choices,
  });
}

class ScenarioChoice {
  final String text;
  final bool isCorrect;
  final String feedback;
  final int safetyScore;

  const ScenarioChoice({
    required this.text,
    required this.isCorrect,
    required this.feedback,
    required this.safetyScore,
  });
}
