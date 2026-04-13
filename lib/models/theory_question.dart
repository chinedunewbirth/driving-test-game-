class TheoryQuestion {
  final String id;
  final String category;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const TheoryQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}
