import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_driving_test/providers/auth_provider.dart';
import 'package:uk_driving_test/providers/test_provider.dart';
import 'package:uk_driving_test/providers/progress_provider.dart';
import 'package:uk_driving_test/providers/payment_provider.dart';
import 'package:uk_driving_test/screens/auth/login_screen.dart';
import 'package:uk_driving_test/screens/home_screen.dart';
import 'package:uk_driving_test/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaymentProvider.initialize();
  runApp(const UKDrivingTestApp());
}

class UKDrivingTestApp extends StatelessWidget {
  const UKDrivingTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..tryAutoLogin()),
        ChangeNotifierProvider(create: (_) => TestProvider()),
        ChangeNotifierProvider(
          create: (_) => ProgressProvider()..loadProgress(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentProvider()..loadSubscription(),
        ),
      ],
      child: MaterialApp(
        title: 'UK Driving Test',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const _AuthGate(),
      ),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return auth.isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}
