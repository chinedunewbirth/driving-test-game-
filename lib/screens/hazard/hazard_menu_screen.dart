import 'package:flutter/material.dart';
import 'package:uk_driving_test/data/hazard_clip_bank.dart';
import 'package:uk_driving_test/screens/hazard/hazard_test_screen.dart';

class HazardMenuScreen extends StatelessWidget {
  const HazardMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clips = HazardClipBank.allClips;

    return Scaffold(
      appBar: AppBar(title: const Text('Hazard Perception')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Full test card
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HazardTestScreen()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFE65100),
                      const Color(0xFFE65100).withAlpha(180),
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
                            Icons.play_circle_filled,
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
                                'Full Hazard Test',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '14 clips • Pass mark: 44/75',
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
                      'Watch simulated driving scenarios and tap when you spot a developing hazard. '
                      'Score up to 5 points per hazard based on response speed.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Practice Individual Clips',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: theme.colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tap the screen as soon as you notice a developing hazard. '
                      'Earlier responses score higher (max 5 points). '
                      'Don\'t tap repeatedly — that will score zero!',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...clips.map(
            (clip) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _scenarioColor(clip.scenarioType),
                  child: Icon(
                    _scenarioIcon(clip.scenarioType),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(clip.title),
                subtitle: Text(
                  '${clip.hazards.length} hazard${clip.hazards.length > 1 ? "s" : ""} • ${clip.scenarioType}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HazardTestScreen(singleClipId: clip.id),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _scenarioColor(String type) {
    switch (type) {
      case 'residential':
        return Colors.green;
      case 'rural':
        return Colors.brown;
      case 'motorway':
        return Colors.blue;
      case 'urban':
        return Colors.orange;
      case 'dual_carriageway':
        return Colors.indigo;
      case 'junction':
        return Colors.purple;
      case 'night':
        return Colors.blueGrey;
      case 'school':
        return Colors.pink;
      case 'wet':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _scenarioIcon(String type) {
    switch (type) {
      case 'residential':
        return Icons.home;
      case 'rural':
        return Icons.nature;
      case 'motorway':
        return Icons.speed;
      case 'urban':
        return Icons.location_city;
      case 'dual_carriageway':
        return Icons.swap_horiz;
      case 'junction':
        return Icons.call_split;
      case 'night':
        return Icons.nightlight;
      case 'school':
        return Icons.school;
      case 'wet':
        return Icons.water_drop;
      default:
        return Icons.warning;
    }
  }
}
