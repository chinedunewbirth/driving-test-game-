import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uk_driving_test/providers/test_provider.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';
import 'package:uk_driving_test/screens/theory/theory_result_screen.dart';

class TheoryTestScreen extends StatefulWidget {
  final String? category;
  const TheoryTestScreen({super.key, this.category});

  @override
  State<TheoryTestScreen> createState() => _TheoryTestScreenState();
}

class _TheoryTestScreenState extends State<TheoryTestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestProvider>().startTheoryTest(
        category: widget.category,
        questionCount: widget.category != null ? 15 : 50,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final test = context.watch<TestProvider>();
    final question = test.currentQuestion;

    if (question == null && !test.isComplete) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (test.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final result = test.getResult();
        context.read<ProgressProvider>().recordTheoryResult(
          result.score,
          result.totalQuestions,
          result.passed,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => TheoryResultScreen(result: result)),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final progress = (test.currentIndex + 1) / test.totalQuestions;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category ?? 'Theory Test'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _showExitDialog(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${test.currentIndex + 1}/${test.totalQuestions}',
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
              progressColor: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        question!.category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.question,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(question.options.length, (index) {
                      final isSelected =
                          test.answers[test.currentIndex] == index;
                      final isCorrect = index == question.correctAnswerIndex;
                      Color? cardColor;
                      IconData? trailingIcon;

                      if (test.showExplanation) {
                        if (isCorrect) {
                          cardColor = Colors.green.withAlpha(30);
                          trailingIcon = Icons.check_circle;
                        } else if (isSelected && !isCorrect) {
                          cardColor = Colors.red.withAlpha(30);
                          trailingIcon = Icons.cancel;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          color: cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: isSelected && !test.showExplanation
                                ? BorderSide(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  )
                                : BorderSide.none,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: test.showExplanation
                                ? null
                                : () => test.answerQuestion(index),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme
                                                .colorScheme
                                                .surfaceContainerHighest,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? theme.colorScheme.onPrimary
                                            : theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  if (trailingIcon != null)
                                    Icon(
                                      trailingIcon,
                                      color: isCorrect
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    if (test.showExplanation) ...[
                      const SizedBox(height: 8),
                      Card(
                        color: theme.colorScheme.tertiaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  question.explanation,
                                  style: TextStyle(
                                    color:
                                        theme.colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: test.nextQuestion,
                          child: Text(
                            test.currentIndex < test.totalQuestions - 1
                                ? 'Next Question'
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
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exit Test?'),
        content: const Text(
          'Your progress will be lost. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Continue Test'),
          ),
          TextButton(
            onPressed: () {
              context.read<TestProvider>().reset();
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
