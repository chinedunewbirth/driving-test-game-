import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = context.watch<ProgressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmReset(context, progress),
            tooltip: 'Reset progress',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall progress
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 50,
                      lineWidth: 8,
                      percent: progress.overallProgress.clamp(0, 1),
                      center: Text(
                        '${(progress.overallProgress * 100).round()}%',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: theme.colorScheme.primary,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Overall Readiness',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Module stats
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    theme: theme,
                    title: 'Theory',
                    icon: Icons.quiz,
                    color: const Color(0xFF1B5E20),
                    stats: [
                      'Tests: ${progress.theoryTestsTaken}',
                      'Passed: ${progress.theoryTestsPassed}',
                      'Best: ${progress.bestTheoryScore}%',
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(
                    theme: theme,
                    title: 'Hazard',
                    icon: Icons.warning_amber,
                    color: const Color(0xFFE65100),
                    stats: [
                      'Tests: ${progress.hazardTestsTaken}',
                      'Best: ${progress.bestHazardScore}/75',
                      progress.bestHazardScore >= 44
                          ? 'Pass level!'
                          : 'Need 44+',
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            _StatCard(
              theme: theme,
              title: 'Driving Scenarios',
              icon: Icons.route,
              color: const Color(0xFF0D47A1),
              stats: [
                'Completed: ${progress.scenariosCompleted}',
                'Best score: ${progress.bestScenarioScore}%',
              ],
            ),
            const SizedBox(height: 24),

            // Recent results
            Text(
              'Recent Results',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (progress.recentResults.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: 48,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No tests completed yet',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...progress.recentResults.map((r) {
                final date = DateTime.tryParse(r['date'] ?? '');
                final dateStr = date != null
                    ? '${date.day}/${date.month}/${date.year}'
                    : '';
                final passed = r['passed'] == true;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: passed
                          ? Colors.green.withAlpha(40)
                          : Colors.red.withAlpha(40),
                      child: Icon(
                        passed ? Icons.check : Icons.close,
                        color: passed ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(r['type'] ?? 'Unknown'),
                    subtitle: Text(dateStr),
                    trailing: Text(
                      '${r['score']}${r['type'] == 'Hazard Perception' ? '/75' : '%'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: passed ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, ProgressProvider progress) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text(
          'This will delete all your progress and results. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              progress.resetProgress();
              Navigator.pop(ctx);
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final IconData icon;
  final Color color;
  final List<String> stats;

  const _StatCard({
    required this.theme,
    required this.title,
    required this.icon,
    required this.color,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...stats.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(s, style: theme.textTheme.bodySmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
