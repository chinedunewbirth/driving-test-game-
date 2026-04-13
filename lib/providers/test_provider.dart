import 'package:flutter/material.dart';
import 'package:uk_driving_test/models/theory_question.dart';
import 'package:uk_driving_test/models/test_result.dart';
import 'package:uk_driving_test/data/theory_question_bank.dart';

class TestProvider extends ChangeNotifier {
  List<TheoryQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  Map<int, int?> _answers = {};
  bool _showExplanation = false;
  DateTime? _startTime;

  List<TheoryQuestion> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  Map<int, int?> get answers => _answers;
  bool get showExplanation => _showExplanation;
  TheoryQuestion? get currentQuestion =>
      _questions.isNotEmpty && _currentIndex < _questions.length
      ? _questions[_currentIndex]
      : null;
  bool get isComplete =>
      _currentIndex >= _questions.length && _questions.isNotEmpty;
  int get totalQuestions => _questions.length;
  int get answeredCount => _answers.length;

  void startTheoryTest({String? category, int questionCount = 50}) {
    if (category != null) {
      _questions = TheoryQuestionBank.byCategory(category);
      if (_questions.length > questionCount) {
        _questions = (_questions..shuffle()).take(questionCount).toList();
      }
    } else {
      _questions = TheoryQuestionBank.mockExam(count: questionCount);
    }
    _currentIndex = 0;
    _score = 0;
    _answers = {};
    _showExplanation = false;
    _startTime = DateTime.now();
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (_showExplanation) return;
    _answers[_currentIndex] = selectedIndex;
    if (selectedIndex == _questions[_currentIndex].correctAnswerIndex) {
      _score++;
    }
    _showExplanation = true;
    notifyListeners();
  }

  void nextQuestion() {
    _showExplanation = false;
    _currentIndex++;
    notifyListeners();
  }

  TestResult getResult() {
    final timeTaken = _startTime != null
        ? DateTime.now().difference(_startTime!)
        : Duration.zero;
    return TestResult(
      testType: 'Theory Test',
      score: _score,
      totalQuestions: _questions.length,
      passScore: (_questions.length * 0.86).ceil(),
      timeTaken: timeTaken,
    );
  }

  void reset() {
    _questions = [];
    _currentIndex = 0;
    _score = 0;
    _answers = {};
    _showExplanation = false;
    _startTime = null;
    notifyListeners();
  }
}
