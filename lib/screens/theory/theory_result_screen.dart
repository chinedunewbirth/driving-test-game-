import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uk_driving_test/models/test_result.dart';

class TheoryResultScreen extends StatefulWidget {
  final TestResult result;
  const TheoryResultScreen({super.key, required this.result});

  @override
  State<TheoryResultScreen> createState() => _TheoryResultScreenState();
}

class _TheoryResultScreenState extends State<TheoryResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    if (widget.result.passed) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = widget.result;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      result.passed
                          ? Icons.emoji_events_rounded
                          : Icons.refresh_rounded,
                      size: 80,
                      color: result.passed ? Colors.amber : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      result.passed ? 'Congratulations!' : 'Keep Practising!',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: result.passed
                            ? Colors.green
                            : theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result.passed
                          ? 'You passed the theory test!'
                          : 'You didn\'t quite pass this time. Keep practising!',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    CircularPercentIndicator(
                      radius: 70,
                      lineWidth: 10,
                      percent: (result.percentage / 100).clamp(0, 1),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${result.score}/${result.totalQuestions}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${result.percentage.round()}%',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      progressColor: result.passed ? Colors.green : Colors.red,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _ResultRow(
                              label: 'Score',
                              value: '${result.score}/${result.totalQuestions}',
                            ),
                            const Divider(),
                            _ResultRow(
                              label: 'Pass Mark',
                              value:
                                  '${result.passScore}/${result.totalQuestions}',
                            ),
                            const Divider(),
                            _ResultRow(
                              label: 'Result',
                              value: result.passed ? 'PASSED' : 'FAILED',
                              valueColor: result.passed
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const Divider(),
                            _ResultRow(
                              label: 'Time Taken',
                              value: _formatDuration(result.timeTaken),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text('Back to Home'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ResultRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
