import 'package:flutter/material.dart';
import 'package:uk_driving_test/data/theory_question_bank.dart';
import 'package:uk_driving_test/screens/theory/theory_test_screen.dart';

class TheoryMenuScreen extends StatelessWidget {
  const TheoryMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = TheoryQuestionBank.categories;

    return Scaffold(
      appBar: AppBar(title: const Text('Theory Test')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Full mock exam card
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TheoryTestScreen()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withAlpha(180),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.assignment_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Mock Exam',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '50 questions • 57 minutes • Pass mark: 43/50',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Simulate the real DVSA theory test with randomised questions from all categories.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Practice by Category',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...categories.map((category) {
            final count = TheoryQuestionBank.byCategory(category).length;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    _categoryIcon(category),
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text(category),
                subtitle: Text('$count questions'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TheoryTestScreen(category: category),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Alertness':
        return Icons.visibility;
      case 'Attitude':
        return Icons.psychology;
      case 'Documents':
        return Icons.description;
      case 'Hazard Awareness':
        return Icons.warning_amber;
      case 'Incidents':
        return Icons.local_hospital;
      case 'Motorway Rules':
        return Icons.speed;
      case 'Road & Traffic Signs':
        return Icons.signpost;
      case 'Rules of the Road':
        return Icons.gavel;
      case 'Safety & Your Vehicle':
        return Icons.build;
      case 'Safety Margins':
        return Icons.straighten;
      case 'Vehicle Handling':
        return Icons.settings;
      case 'Vulnerable Road Users':
        return Icons.accessible;
      default:
        return Icons.quiz;
    }
  }
}
