import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:confetti/confetti.dart';
import 'package:uk_driving_test/models/driving_scenario.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';

class DrivingScenarioScreen extends StatefulWidget {
  final DrivingScenario scenario;
  const DrivingScenarioScreen({super.key, required this.scenario});

  @override
  State<DrivingScenarioScreen> createState() => _DrivingScenarioScreenState();
}

class _DrivingScenarioScreenState extends State<DrivingScenarioScreen> {
  int _currentStep = 0;
  int _totalSafetyScore = 0;
  int _maxPossibleScore = 0;
  bool _choiceMade = false;
  ScenarioChoice? _selectedChoice;
  late ConfettiController _confettiController;

  DrivingScenario get scenario => widget.scenario;
  ScenarioStep get currentStep => scenario.steps[_currentStep];
  bool get isComplete => _currentStep >= scenario.steps.length;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    for (final step in scenario.steps) {
      _maxPossibleScore += step.choices
          .map((c) => c.safetyScore)
          .reduce((a, b) => a > b ? a : b);
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _selectChoice(ScenarioChoice choice) {
    if (_choiceMade) return;
    setState(() {
      _selectedChoice = choice;
      _choiceMade = true;
      _totalSafetyScore += choice.safetyScore;
    });
  }

  void _nextStep() {
    if (_currentStep < scenario.steps.length - 1) {
      setState(() {
        _currentStep++;
        _choiceMade = false;
        _selectedChoice = null;
      });
    } else {
      setState(() {
        _currentStep = scenario.steps.length; // Mark complete
      });
      final pct = ((_totalSafetyScore / _maxPossibleScore) * 100).round();
      context.read<ProgressProvider>().recordScenarioResult(
        _totalSafetyScore,
        _maxPossibleScore,
      );
      if (pct >= 70) {
        _confettiController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isComplete) {
      return _buildResultsView(theme);
    }

    final progress = (_currentStep + 1) / scenario.steps.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(scenario.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Step ${_currentStep + 1}/${scenario.steps.length}',
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearPercentIndicator(
            lineHeight: 4,
            percent: progress.clamp(0, 1),
            padding: EdgeInsets.zero,
            progressColor: const Color(0xFF0D47A1),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scene illustration
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF64B5F6),
                          const Color(0xFF424242),
                        ],
                      ),
                    ),
                    child: CustomPaint(
                      painter: _SceneIllustrationPainter(
                        step: _currentStep,
                        scenarioId: scenario.id,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              scenario.difficulty,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Narrative
                  Card(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_stories,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              currentStep.narrative,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Question
                  Text(
                    currentStep.situation,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Choices
                  ...currentStep.choices.map((choice) {
                    final isSelected = _selectedChoice == choice;
                    Color? cardColor;
                    IconData? icon;

                    if (_choiceMade) {
                      if (choice.isCorrect) {
                        cardColor = Colors.green.withAlpha(30);
                        icon = Icons.check_circle;
                      } else if (isSelected && !choice.isCorrect) {
                        cardColor = Colors.red.withAlpha(30);
                        icon = Icons.cancel;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: isSelected && !_choiceMade
                              ? BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                )
                              : BorderSide.none,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _choiceMade
                              ? null
                              : () => _selectChoice(choice),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    choice.text,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                if (icon != null)
                                  Icon(
                                    icon,
                                    color: choice.isCorrect
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                if (_choiceMade)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _safetyColor(
                                          choice.safetyScore,
                                        ).withAlpha(40),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${choice.safetyScore}%',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _safetyColor(
                                            choice.safetyScore,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // Feedback
                  if (_choiceMade && _selectedChoice != null) ...[
                    const SizedBox(height: 8),
                    Card(
                      color: _selectedChoice!.isCorrect
                          ? Colors.green.withAlpha(20)
                          : Colors.orange.withAlpha(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _selectedChoice!.isCorrect
                                  ? Icons.thumb_up
                                  : Icons.lightbulb_outline,
                              color: _selectedChoice!.isCorrect
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(_selectedChoice!.feedback)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        child: Text(
                          _currentStep < scenario.steps.length - 1
                              ? 'Next Step'
                              : 'See Results',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(ThemeData theme) {
    final pct = ((_totalSafetyScore / _maxPossibleScore) * 100).round();
    final passed = pct >= 70;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    passed ? Icons.emoji_events : Icons.refresh,
                    size: 64,
                    color: passed ? Colors.amber : Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    passed ? 'Excellent Driving!' : 'Needs Improvement',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: passed ? Colors.green : theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scenario.title,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  CircularPercentIndicator(
                    radius: 60,
                    lineWidth: 8,
                    percent: (pct / 100).clamp(0, 1).toDouble(),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$pct%',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Safety', style: theme.textTheme.bodySmall),
                      ],
                    ),
                    progressColor: passed ? Colors.green : Colors.red,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _InfoRow(
                            'Safety Score',
                            '$_totalSafetyScore / $_maxPossibleScore',
                          ),
                          const Divider(),
                          _InfoRow('Pass Mark', '70%'),
                          const Divider(),
                          _InfoRow(
                            'Result',
                            passed ? 'PASSED' : 'FAILED',
                            valueColor: passed ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.popUntil(context, (r) => r.isFirst),
                      child: const Text('Back to Home'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep = 0;
                          _totalSafetyScore = 0;
                          _choiceMade = false;
                          _selectedChoice = null;
                        });
                      },
                      child: const Text('Try Again'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
            ),
          ),
        ],
      ),
    );
  }

  Color _safetyColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class _SceneIllustrationPainter extends CustomPainter {
  final int step;
  final String scenarioId;

  _SceneIllustrationPainter({required this.step, required this.scenarioId});

  @override
  void paint(Canvas canvas, Size size) {
    // Road surface
    final roadPaint = Paint()..color = const Color(0xFF616161);
    final roadPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.4)
      ..lineTo(size.width * 0.75, size.height * 0.4)
      ..lineTo(size.width * 0.95, size.height)
      ..lineTo(size.width * 0.05, size.height)
      ..close();
    canvas.drawPath(roadPath, roadPaint);

    // Dashed lines
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    for (double t = 0; t < 1; t += 0.2) {
      final y = size.height * 0.4 + size.height * 0.6 * t;
      canvas.drawLine(
        Offset(size.width * 0.5, y),
        Offset(size.width * 0.5, y + 10),
        linePaint,
      );
    }

    // Scenario-specific elements
    if (scenarioId.contains('parking') ||
        scenarioId == 'ds_01' ||
        scenarioId == 'ds_06') {
      // Parked cars
      final carPaint = Paint()..color = Colors.red.shade700;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.1, size.height * 0.55, 35, 18),
          const Radius.circular(4),
        ),
        carPaint,
      );
      carPaint.color = Colors.blue.shade700;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.1, size.height * 0.78, 35, 18),
          const Radius.circular(4),
        ),
        carPaint,
      );
    } else if (scenarioId == 'ds_02') {
      // Roundabout circle
      final roundaboutPaint = Paint()
        ..color = Colors.green.shade600
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.45),
        20,
        roundaboutPaint,
      );
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.45),
        20,
        borderPaint,
      );
    }

    // Dashboard
    final dashPaint = Paint()..color = const Color(0xFF212121);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.9, size.width, size.height * 0.1),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
