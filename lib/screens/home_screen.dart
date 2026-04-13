import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';
import 'package:uk_driving_test/screens/auth/profile_screen.dart';
import 'package:uk_driving_test/screens/payment/subscription_screen.dart';
import 'package:uk_driving_test/screens/theory/theory_menu_screen.dart';
import 'package:uk_driving_test/screens/hazard/hazard_menu_screen.dart';
import 'package:uk_driving_test/screens/driving/driving_menu_screen.dart';
import 'package:uk_driving_test/screens/progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = context.watch<ProgressProvider>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.workspace_premium,
                    color: Colors.amber,
                  ),
                  tooltip: 'Premium',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SubscriptionScreen(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.white),
                  tooltip: 'Profile',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'UK Driving Test',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.drive_eta_rounded,
                          size: 64,
                          color: theme.colorScheme.onPrimary.withAlpha(200),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pass Your Test With Confidence',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Progress overview card
                  Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProgressScreen(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 35,
                              lineWidth: 6,
                              percent: progress.overallProgress.clamp(0, 1),
                              center: Text(
                                '${(progress.overallProgress * 100).round()}%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              progressColor: theme.colorScheme.primary,
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerHighest,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Progress',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${progress.theoryTestsTaken} theory tests • ${progress.hazardTestsTaken} hazard tests • ${progress.scenariosCompleted} scenarios',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Practice Modules',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Theory Test
                  _ModuleCard(
                    icon: Icons.quiz_rounded,
                    title: 'Theory Test',
                    subtitle:
                        '50 multiple-choice questions covering all DVSA categories',
                    color: const Color(0xFF1B5E20),
                    stats:
                        '${progress.theoryTestsPassed}/${progress.theoryTestsTaken} passed',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TheoryMenuScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Hazard Perception
                  _ModuleCard(
                    icon: Icons.warning_amber_rounded,
                    title: 'Hazard Perception',
                    subtitle:
                        'Spot developing hazards in 14 interactive video-style clips',
                    color: const Color(0xFFE65100),
                    stats: 'Best: ${progress.bestHazardScore}/75',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HazardMenuScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Virtual Driving
                  _ModuleCard(
                    icon: Icons.route_rounded,
                    title: 'Virtual Driving Scenarios',
                    subtitle:
                        '8 interactive scenarios: parking, roundabouts, motorways & more',
                    color: const Color(0xFF0D47A1),
                    stats: '${progress.scenariosCompleted} completed',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DrivingMenuScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Quick tips
                  Card(
                    color: theme.colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Did You Know?',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The UK theory test has 50 multiple-choice questions. You need to score at least 43 out of 50 (86%) to pass. '
                            'The hazard perception test requires a minimum score of 44 out of 75.',
                            style: TextStyle(
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String stats;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.stats,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color, color.withAlpha(180)]),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stats,
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(subtitle, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
