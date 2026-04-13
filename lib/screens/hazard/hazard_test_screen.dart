import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uk_driving_test/data/hazard_clip_bank.dart';
import 'package:uk_driving_test/models/hazard_clip.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';

class HazardTestScreen extends StatefulWidget {
  final String? singleClipId;
  const HazardTestScreen({super.key, this.singleClipId});

  @override
  State<HazardTestScreen> createState() => _HazardTestScreenState();
}

class _HazardTestScreenState extends State<HazardTestScreen>
    with TickerProviderStateMixin {
  late List<HazardClip> _clips;
  int _currentClipIndex = 0;
  double _elapsedSeconds = 0;
  Timer? _timer;
  bool _isPlaying = false;
  int _totalScore = 0;
  final List<int> _clipScores = [];
  final List<double> _tapTimes = [];
  bool _showingResult = false;
  bool _testComplete = false;
  int _tapCount = 0;
  static const int _maxTapsPerClip = 10;

  // Animation state for the road scene
  late AnimationController _roadAnimController;
  late AnimationController _hazardPulseController;
  bool _hazardVisible = false;
  String _currentHazardDescription = '';

  HazardClip get _currentClip => _clips[_currentClipIndex];

  @override
  void initState() {
    super.initState();
    if (widget.singleClipId != null) {
      _clips = [HazardClipBank.getById(widget.singleClipId!)];
    } else {
      _clips = List.from(HazardClipBank.allClips)..shuffle();
    }

    _roadAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _hazardPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.8,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _roadAnimController.dispose();
    _hazardPulseController.dispose();
    super.dispose();
  }

  void _startClip() {
    setState(() {
      _elapsedSeconds = 0;
      _isPlaying = true;
      _tapTimes.clear();
      _tapCount = 0;
      _hazardVisible = false;
      _showingResult = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _elapsedSeconds += 0.1;

        // Check if any hazard should become visible
        for (final hazard in _currentClip.hazards) {
          if (_elapsedSeconds >= hazard.appearTimeSeconds - 2 &&
              _elapsedSeconds <= hazard.deadlineSeconds) {
            _hazardVisible = true;
            _currentHazardDescription = hazard.description;
          }
        }

        if (_elapsedSeconds >= _currentClip.durationSeconds) {
          _endClip();
        }
      });
    });
  }

  void _handleTap(TapDownDetails details) {
    if (!_isPlaying || _showingResult) return;

    _tapCount++;
    _tapTimes.add(_elapsedSeconds);

    // Visual feedback
    ScaffoldMessenger.of(context).clearSnackBars();

    if (_tapCount > _maxTapsPerClip) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Too many taps! Your score for this clip will be zero.',
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show tap indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tap registered at ${_elapsedSeconds.toStringAsFixed(1)}s',
        ),
        duration: const Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _endClip() {
    _timer?.cancel();
    _isPlaying = false;

    int clipScore = 0;

    if (_tapCount <= _maxTapsPerClip) {
      for (final hazard in _currentClip.hazards) {
        int bestScore = 0;
        for (final tapTime in _tapTimes) {
          final score = hazard.scoreForResponseTime(tapTime);
          if (score > bestScore) bestScore = score;
        }
        clipScore += bestScore;
      }
    }

    _clipScores.add(clipScore);
    _totalScore += clipScore;

    setState(() {
      _showingResult = true;
    });
  }

  void _nextClip() {
    if (_currentClipIndex < _clips.length - 1) {
      setState(() {
        _currentClipIndex++;
        _showingResult = false;
        _hazardVisible = false;
      });
    } else {
      setState(() {
        _testComplete = true;
      });
      context.read<ProgressProvider>().recordHazardResult(_totalScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_testComplete) {
      return _buildResultScreen(theme);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.singleClipId != null
              ? _currentClip.title
              : 'Clip ${_currentClipIndex + 1}/${_clips.length}',
        ),
      ),
      body: Column(
        children: [
          if (_isPlaying)
            LinearPercentIndicator(
              lineHeight: 4,
              percent: (_elapsedSeconds / _currentClip.durationSeconds).clamp(
                0,
                1,
              ),
              padding: EdgeInsets.zero,
              progressColor: const Color(0xFFE65100),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          Expanded(
            child: _isPlaying || _showingResult
                ? _buildClipView(theme)
                : _buildClipIntro(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildClipIntro(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE65100).withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_circle_filled,
              size: 64,
              color: Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _currentClip.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _currentClip.description,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${_currentClip.hazards.length} hazard${_currentClip.hazards.length > 1 ? "s" : ""} to spot • ${_currentClip.durationSeconds}s duration',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(150),
            ),
          ),
          const SizedBox(height: 32),
          Card(
            color: theme.colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: theme.colorScheme.onTertiaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Instructions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Tap the screen when you spot a developing hazard\n'
                    '• Respond quickly for a higher score (max 5 points)\n'
                    '• Don\'t tap more than 10 times per clip\n'
                    '• Watch the road scene and react naturally',
                    style: TextStyle(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _startClip,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Clip'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE65100),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClipView(ThemeData theme) {
    return GestureDetector(
      onTapDown: _handleTap,
      child: Stack(
        children: [
          // Animated road scene
          AnimatedBuilder(
            animation: _roadAnimController,
            builder: (context, child) {
              return CustomPaint(
                painter: _RoadScenePainter(
                  progress: _roadAnimController.value,
                  elapsed: _elapsedSeconds,
                  scenarioType: _currentClip.scenarioType,
                  hazardVisible: _hazardVisible,
                  hazardPulse: _hazardPulseController.value,
                  hazards: _currentClip.hazards,
                ),
                size: Size.infinite,
              );
            },
          ),

          // HUD overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HudBadge(
                  icon: Icons.timer,
                  text:
                      '${_elapsedSeconds.toStringAsFixed(0)}s / ${_currentClip.durationSeconds}s',
                ),
                _HudBadge(
                  icon: Icons.touch_app,
                  text: 'Taps: $_tapCount / $_maxTapsPerClip',
                ),
              ],
            ),
          ),

          // Hazard description overlay
          if (_hazardVisible && !_showingResult)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: AnimatedOpacity(
                opacity: _hazardVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Watch carefully for developing hazards...',
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Tap hint
          if (_isPlaying && !_showingResult)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'TAP when you spot a hazard',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ),
            ),

          // Clip result overlay
          if (_showingResult)
            Container(
              color: Colors.black54,
              child: Center(
                child: Card(
                  margin: const EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _clipScores.last > 0
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 48,
                          color: _clipScores.last > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Clip Score: ${_clipScores.last}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Max possible: ${_currentClip.hazards.length * 5}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (_tapCount > _maxTapsPerClip)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Score zeroed due to excessive tapping',
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          _currentHazardDescription,
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _nextClip,
                            child: Text(
                              _currentClipIndex < _clips.length - 1
                                  ? 'Next Clip'
                                  : 'See Results',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(ThemeData theme) {
    final maxPossible = _clips.fold<int>(
      0,
      (sum, clip) => sum + clip.hazards.length * 5,
    );
    final passed = _totalScore >= 44;

    return Scaffold(
      appBar: AppBar(title: const Text('Hazard Perception Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              passed ? Icons.emoji_events : Icons.refresh,
              size: 64,
              color: passed ? Colors.amber : Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              passed ? 'Well Done!' : 'Keep Practising!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: passed ? Colors.green : theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            CircularPercentIndicator(
              radius: 60,
              lineWidth: 8,
              percent: (maxPossible > 0 ? _totalScore / maxPossible : 0)
                  .clamp(0, 1)
                  .toDouble(),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_totalScore',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('of $maxPossible', style: theme.textTheme.bodySmall),
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
                    ...List.generate(_clips.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _clips[i].title,
                                style: theme.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${_clipScores[i]}/${_clips[i].hazards.length * 5}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _clipScores[i] > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pass mark: 44/$maxPossible',
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          passed ? 'PASSED' : 'FAILED',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: passed ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HudBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HudBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}

class _RoadScenePainter extends CustomPainter {
  final double progress;
  final double elapsed;
  final String scenarioType;
  final bool hazardVisible;
  final double hazardPulse;
  final List<HazardEvent> hazards;

  _RoadScenePainter({
    required this.progress,
    required this.elapsed,
    required this.scenarioType,
    required this.hazardVisible,
    required this.hazardPulse,
    required this.hazards,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Sky gradient
    final skyColors = _getSkyColors();
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: skyColors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.45));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.45),
      skyPaint,
    );

    // Ground / grass area
    final groundPaint = Paint()..color = _getGroundColor();
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.45, size.width, size.height * 0.55),
      groundPaint,
    );

    // Road
    final roadPaint = Paint()..color = const Color(0xFF424242);
    final roadPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.45)
      ..lineTo(size.width * 0.7, size.height * 0.45)
      ..lineTo(size.width * 0.9, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();
    canvas.drawPath(roadPath, roadPaint);

    // Road markings (animated dashed centre line)
    final markingPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3;

    for (int i = 0; i < 8; i++) {
      final t = ((progress + i * 0.125) % 1.0);
      final y = size.height * 0.45 + (size.height * 0.55 * t);
      final x = size.width * 0.5;
      final dashLength = 12.0 + t * 8;

      if (t < 0.9) {
        canvas.drawLine(Offset(x, y), Offset(x, y + dashLength), markingPaint);
      }
    }

    // Roadside elements based on scenario type
    _drawScenarioElements(canvas, size);

    // Hazard indicator
    if (hazardVisible) {
      for (final hazard in hazards) {
        if (elapsed >= hazard.appearTimeSeconds - 2 &&
            elapsed <= hazard.deadlineSeconds) {
          final hx = size.width * hazard.positionX;
          final hy = size.height * hazard.positionY;

          // Pulsing warning circle
          final warningPaint = Paint()
            ..color = Colors.red.withAlpha((60 * hazardPulse).toInt())
            ..style = PaintingStyle.fill;
          canvas.drawCircle(Offset(hx, hy), 40 * hazardPulse, warningPaint);

          // Hazard icon area
          final iconPaint = Paint()
            ..color = Colors.amber.withAlpha((180 * hazardPulse).toInt())
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
          canvas.drawCircle(Offset(hx, hy), 25, iconPaint);

          // Exclamation mark
          final textPainter = TextPainter(
            text: TextSpan(
              text: '⚠',
              style: TextStyle(
                fontSize: 24,
                color: Colors.amber.withAlpha(200),
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          textPainter.paint(canvas, Offset(hx - 12, hy - 14));
        }
      }
    }

    // Dashboard at bottom
    final dashPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;
    final dashRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.88,
        size.width * 0.7,
        size.height * 0.12,
      ),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
    );
    canvas.drawRRect(dashRect, dashPaint);

    // Steering wheel hint
    final wheelPaint = Paint()
      ..color = Colors.grey.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.94),
      25,
      wheelPaint,
    );

    // Speed indicator
    final speedText = TextPainter(
      text: TextSpan(
        text: _getSpeed(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    speedText.paint(canvas, Offset(size.width * 0.25, size.height * 0.92));
  }

  List<Color> _getSkyColors() {
    switch (scenarioType) {
      case 'night':
        return [const Color(0xFF0D1B2A), const Color(0xFF1B3A4B)];
      case 'wet':
        return [const Color(0xFF546E7A), const Color(0xFF78909C)];
      default:
        return [const Color(0xFF64B5F6), const Color(0xFFBBDEFB)];
    }
  }

  Color _getGroundColor() {
    switch (scenarioType) {
      case 'motorway':
      case 'dual_carriageway':
        return const Color(0xFF558B2F);
      case 'urban':
      case 'junction':
        return const Color(0xFF9E9E9E);
      case 'night':
        return const Color(0xFF1B3A1B);
      default:
        return const Color(0xFF66BB6A);
    }
  }

  String _getSpeed() {
    switch (scenarioType) {
      case 'motorway':
        return '65 mph';
      case 'dual_carriageway':
        return '55 mph';
      case 'residential':
      case 'school':
        return '25 mph';
      case 'urban':
      case 'junction':
        return '30 mph';
      default:
        return '40 mph';
    }
  }

  void _drawScenarioElements(Canvas canvas, Size size) {
    final paint = Paint();

    switch (scenarioType) {
      case 'residential':
      case 'school':
        // Houses on sides
        paint.color = const Color(0xFFD32F2F);
        canvas.drawRect(Rect.fromLTWH(10, size.height * 0.3, 60, 50), paint);
        canvas.drawRect(
          Rect.fromLTWH(size.width - 70, size.height * 0.3, 60, 50),
          paint,
        );
        // Roofs
        paint.color = const Color(0xFF5D4037);
        final roofPath = Path()
          ..moveTo(5, size.height * 0.3)
          ..lineTo(40, size.height * 0.22)
          ..lineTo(75, size.height * 0.3)
          ..close();
        canvas.drawPath(roofPath, paint);
        // Parked cars
        paint.color = Colors.blue.shade700;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.15, size.height * 0.6, 40, 20),
            const Radius.circular(4),
          ),
          paint,
        );
        break;

      case 'rural':
        // Trees
        paint.color = const Color(0xFF2E7D32);
        for (int i = 0; i < 3; i++) {
          final tx = 20.0 + i * 30;
          canvas.drawCircle(Offset(tx, size.height * 0.35), 18, paint);
          canvas.drawCircle(
            Offset(size.width - tx, size.height * 0.35),
            15,
            paint,
          );
        }
        // Tree trunks
        paint.color = const Color(0xFF5D4037);
        for (int i = 0; i < 3; i++) {
          final tx = 20.0 + i * 30;
          canvas.drawRect(
            Rect.fromLTWH(tx - 3, size.height * 0.38, 6, 15),
            paint,
          );
        }
        break;

      case 'motorway':
        // Lane markings (multiple lanes)
        paint
          ..color = Colors.white
          ..strokeWidth = 2;
        for (double t = 0; t < 1; t += 0.15) {
          final y = size.height * 0.45 + size.height * 0.55 * t;
          final leftX = size.width * (0.35 + t * -0.1);
          final rightX = size.width * (0.65 + t * 0.1);
          canvas.drawLine(Offset(leftX, y), Offset(leftX, y + 8), paint);
          canvas.drawLine(Offset(rightX, y), Offset(rightX, y + 8), paint);
        }
        // Central reservation
        paint.color = Colors.green.shade800;
        canvas.drawRect(
          Rect.fromLTWH(0, size.height * 0.43, size.width * 0.28, 8),
          paint,
        );
        break;

      case 'urban':
        // Buildings
        paint.color = const Color(0xFF78909C);
        canvas.drawRect(Rect.fromLTWH(0, size.height * 0.2, 50, 80), paint);
        canvas.drawRect(
          Rect.fromLTWH(size.width - 60, size.height * 0.25, 60, 70),
          paint,
        );
        // Windows
        paint.color = const Color(0xFFFFEB3B).withAlpha(150);
        for (int r = 0; r < 3; r++) {
          for (int c = 0; c < 2; c++) {
            canvas.drawRect(
              Rect.fromLTWH(
                8 + c * 18.0,
                size.height * 0.24 + r * 20.0,
                10,
                12,
              ),
              paint,
            );
          }
        }
        break;

      case 'night':
        // Stars
        paint.color = Colors.white;
        final rng = Random(42);
        for (int i = 0; i < 20; i++) {
          canvas.drawCircle(
            Offset(
              rng.nextDouble() * size.width,
              rng.nextDouble() * size.height * 0.35,
            ),
            1.5,
            paint,
          );
        }
        // Headlight beams
        paint
          ..color = Colors.yellow.withAlpha(30)
          ..style = PaintingStyle.fill;
        final beamPath = Path()
          ..moveTo(size.width * 0.4, size.height * 0.88)
          ..lineTo(size.width * 0.3, size.height * 0.45)
          ..lineTo(size.width * 0.7, size.height * 0.45)
          ..lineTo(size.width * 0.6, size.height * 0.88)
          ..close();
        canvas.drawPath(beamPath, paint);
        break;

      default:
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _RoadScenePainter old) => true;
}
