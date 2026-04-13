# UK Driving Test Simulator

A cross-platform mobile app (iOS & Android) built with Flutter that simulates the UK driving test experience.

## Features

### Theory Test
- **50 multiple-choice questions** covering all DVSA categories
- Category-based practice mode (Alertness, Attitude, Safety, Motorway Rules, etc.)
- Full mock exam with 86% pass mark (43/50)
- Instant feedback with explanations for every answer
- Timed test with results tracking

### Hazard Perception
- **14 interactive video-style clips** with animated road scenes
- Tap-to-respond hazard detection system
- Scoring based on response speed (max 5 points per hazard)
- Anti-cheat: excessive tapping zeroes the score
- Multiple scenario types: residential, rural, motorway, urban, night driving
- Pass mark: 44/75

### Virtual Driving Scenarios
- **8 interactive decision-making scenarios**
- Covers: parallel parking, roundabouts, emergency stops, motorway joining, night driving, bay parking, traffic lights, level crossings
- Multiple-choice decisions at each step with safety scoring
- Detailed feedback explaining the safest course of action
- Difficulty levels: Easy, Medium, Hard

### Progress Tracking
- Persistent progress saved locally
- Overall readiness percentage
- Best scores per module
- Recent results history
- Reset option

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run

# Build for release
flutter build apk        # Android
flutter build ios         # iOS
```

## Requirements
- Flutter SDK 3.9+
- Dart 3.9+
- Android Studio / Xcode for device builds

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/app_theme.dart         # Material 3 theming
├── models/                      # Data models
│   ├── theory_question.dart
│   ├── hazard_clip.dart
│   ├── driving_scenario.dart
│   └── test_result.dart
├── data/                        # Question/scenario banks
│   ├── theory_question_bank.dart
│   ├── hazard_clip_bank.dart
│   └── driving_scenario_bank.dart
├── providers/                   # State management
│   ├── test_provider.dart
│   └── progress_provider.dart
└── screens/                     # UI screens
    ├── home_screen.dart
    ├── progress_screen.dart
    ├── theory/
    │   ├── theory_menu_screen.dart
    │   ├── theory_test_screen.dart
    │   └── theory_result_screen.dart
    ├── hazard/
    │   ├── hazard_menu_screen.dart
    │   └── hazard_test_screen.dart
    └── driving/
        ├── driving_menu_screen.dart
        └── driving_scenario_screen.dart
```
Create a mobile app that simulates UK driving tests, including hazard perception, theory questions, and virtual driving scenarios. Use Flutter for cross-platform development (iOS and Android
