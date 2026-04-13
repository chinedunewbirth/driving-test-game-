import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressProvider extends ChangeNotifier {
  int _theoryTestsTaken = 0;
  int _theoryTestsPassed = 0;
  int _bestTheoryScore = 0;
  int _hazardTestsTaken = 0;
  int _bestHazardScore = 0;
  int _scenariosCompleted = 0;
  int _bestScenarioScore = 0;
  List<Map<String, dynamic>> _recentResults = [];

  int get theoryTestsTaken => _theoryTestsTaken;
  int get theoryTestsPassed => _theoryTestsPassed;
  int get bestTheoryScore => _bestTheoryScore;
  int get hazardTestsTaken => _hazardTestsTaken;
  int get bestHazardScore => _bestHazardScore;
  int get scenariosCompleted => _scenariosCompleted;
  int get bestScenarioScore => _bestScenarioScore;
  List<Map<String, dynamic>> get recentResults => _recentResults;

  double get overallProgress {
    int total = 0;
    int achieved = 0;
    // Theory: max 100 points
    total += 100;
    achieved += bestTheoryScore;
    // Hazard: max 75 points
    total += 75;
    achieved += bestHazardScore;
    // Scenarios: count completed
    total += 8; // total scenarios
    achieved += scenariosCompleted.clamp(0, 8);
    return total > 0 ? (achieved / total) : 0;
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _theoryTestsTaken = prefs.getInt('theoryTestsTaken') ?? 0;
    _theoryTestsPassed = prefs.getInt('theoryTestsPassed') ?? 0;
    _bestTheoryScore = prefs.getInt('bestTheoryScore') ?? 0;
    _hazardTestsTaken = prefs.getInt('hazardTestsTaken') ?? 0;
    _bestHazardScore = prefs.getInt('bestHazardScore') ?? 0;
    _scenariosCompleted = prefs.getInt('scenariosCompleted') ?? 0;
    _bestScenarioScore = prefs.getInt('bestScenarioScore') ?? 0;
    final resultsJson = prefs.getString('recentResults');
    if (resultsJson != null) {
      _recentResults = List<Map<String, dynamic>>.from(
        (json.decode(resultsJson) as List).map(
          (e) => Map<String, dynamic>.from(e),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theoryTestsTaken', _theoryTestsTaken);
    await prefs.setInt('theoryTestsPassed', _theoryTestsPassed);
    await prefs.setInt('bestTheoryScore', _bestTheoryScore);
    await prefs.setInt('hazardTestsTaken', _hazardTestsTaken);
    await prefs.setInt('bestHazardScore', _bestHazardScore);
    await prefs.setInt('scenariosCompleted', _scenariosCompleted);
    await prefs.setInt('bestScenarioScore', _bestScenarioScore);
    await prefs.setString('recentResults', json.encode(_recentResults));
  }

  Future<void> recordTheoryResult(int score, int total, bool passed) async {
    _theoryTestsTaken++;
    if (passed) _theoryTestsPassed++;
    final pct = ((score / total) * 100).round();
    if (pct > _bestTheoryScore) _bestTheoryScore = pct;
    _addRecentResult('Theory', pct, passed);
    await _save();
    notifyListeners();
  }

  Future<void> recordHazardResult(int score) async {
    _hazardTestsTaken++;
    if (score > _bestHazardScore) _bestHazardScore = score;
    _addRecentResult('Hazard Perception', score, score >= 44);
    await _save();
    notifyListeners();
  }

  Future<void> recordScenarioResult(int score, int total) async {
    _scenariosCompleted++;
    final pct = ((score / total) * 100).round();
    if (pct > _bestScenarioScore) _bestScenarioScore = pct;
    _addRecentResult('Driving Scenario', pct, pct >= 70);
    await _save();
    notifyListeners();
  }

  void _addRecentResult(String type, int score, bool passed) {
    _recentResults.insert(0, {
      'type': type,
      'score': score,
      'passed': passed,
      'date': DateTime.now().toIso8601String(),
    });
    if (_recentResults.length > 20) {
      _recentResults = _recentResults.take(20).toList();
    }
  }

  Future<void> resetProgress() async {
    _theoryTestsTaken = 0;
    _theoryTestsPassed = 0;
    _bestTheoryScore = 0;
    _hazardTestsTaken = 0;
    _bestHazardScore = 0;
    _scenariosCompleted = 0;
    _bestScenarioScore = 0;
    _recentResults = [];
    await _save();
    notifyListeners();
  }
}
