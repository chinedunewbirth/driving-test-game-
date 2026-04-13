import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uk_driving_test/models/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  // TODO: Replace with your actual Stripe publishable key
  static const String _publishableKey =
      'pk_live_51S11NGEcPzFPLQcT08yaxfw96SXotomAs9lLIk4fx6nWa5JGEznmx6SeU8DGSanxMgvkYo4RwLqSc6eoHzAg8pQB00lLXG2Urz';

  // TODO: Replace with your backend server URL that creates PaymentIntents
  static const String _backendUrl =
      'https://stripe.dev/stripe-android/connect/index.html#-230050311%2FPackages%2F1570623889';

  bool _isPremium = false;
  String? _activePlanId;
  bool _isProcessing = false;
  String? _error;
  DateTime? _purchaseDate;

  bool get isPremium => _isPremium;
  String? get activePlanId => _activePlanId;
  bool get isProcessing => _isProcessing;
  String? get error => _error;
  DateTime? get purchaseDate => _purchaseDate;

  PremiumPlan? get activePlan {
    if (_activePlanId == null) return null;
    try {
      return availablePlans.firstWhere((p) => p.id == _activePlanId);
    } catch (_) {
      return null;
    }
  }

  /// Initialize Stripe SDK — call once at app startup
  static void initialize() {
    Stripe.publishableKey = _publishableKey;
  }

  /// Load saved subscription status from local storage
  Future<void> loadSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('isPremium') ?? false;
    _activePlanId = prefs.getString('activePlanId');
    final purchaseDateStr = prefs.getString('purchaseDate');
    if (purchaseDateStr != null) {
      _purchaseDate = DateTime.tryParse(purchaseDateStr);
    }
    notifyListeners();
  }

  /// Process payment for a selected plan via Stripe
  Future<bool> purchasePlan(PremiumPlan plan) async {
    _isProcessing = true;
    _error = null;
    notifyListeners();

    try {
      // Step 1: Create a PaymentIntent on your backend
      final paymentIntent = await _createPaymentIntent(
        amount: plan.priceInPence,
        currency: 'gbp',
      );

      if (paymentIntent == null) {
        _error = 'Could not connect to payment server';
        _isProcessing = false;
        notifyListeners();
        return false;
      }

      // Step 2: Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['clientSecret'] as String,
          merchantDisplayName: 'UK Driving Test',
          style: ThemeMode.system,
        ),
      );

      // Step 3: Present the payment sheet to the user
      await Stripe.instance.presentPaymentSheet();

      // Step 4: Payment succeeded — save subscription
      await _saveSubscription(plan.id);

      _isProcessing = false;
      notifyListeners();
      return true;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // User cancelled — not an error
        _error = null;
      } else {
        _error = e.error.localizedMessage ?? 'Payment failed';
      }
      _isProcessing = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Payment failed. Please try again.';
      _isProcessing = false;
      notifyListeners();
      return false;
    }
  }

  /// Create PaymentIntent on your backend server
  Future<Map<String, dynamic>?> _createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'amount': amount, 'currency': currency}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Save subscription status locally
  Future<void> _saveSubscription(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    await prefs.setBool('isPremium', true);
    await prefs.setString('activePlanId', planId);
    await prefs.setString('purchaseDate', now.toIso8601String());

    _isPremium = true;
    _activePlanId = planId;
    _purchaseDate = now;
  }

  /// Restore purchases (check backend for active subscription)
  Future<bool> restorePurchases() async {
    _isProcessing = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$_backendUrl/check-subscription'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['active'] == true) {
          await _saveSubscription(data['planId'] as String);
          _isProcessing = false;
          notifyListeners();
          return true;
        }
      }

      _error = 'No active subscription found';
      _isProcessing = false;
      notifyListeners();
      return false;
    } catch (_) {
      _error = 'Could not connect to server';
      _isProcessing = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
