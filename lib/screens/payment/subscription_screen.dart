import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_driving_test/models/payment_model.dart';
import 'package:uk_driving_test/providers/payment_provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payment = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Premium'),
        actions: [
          if (!payment.isPremium)
            TextButton(
              onPressed: payment.isProcessing
                  ? null
                  : () => _restorePurchases(context),
              child: const Text('Restore'),
            ),
        ],
      ),
      body: payment.isPremium
          ? _ActiveSubscription(payment: payment)
          : _PlanSelection(payment: payment),
    );
  }

  Future<void> _restorePurchases(BuildContext context) async {
    final payment = context.read<PaymentProvider>();
    final success = await payment.restorePurchases();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Subscription restored!'
                : payment.error ?? 'No subscription found',
          ),
        ),
      );
    }
  }
}

class _ActiveSubscription extends StatelessWidget {
  final PaymentProvider payment;

  const _ActiveSubscription({required this.payment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plan = payment.activePlan;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ],
                ),
              ),
              child: const Icon(
                Icons.workspace_premium,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'You\'re Premium!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (plan != null)
              Text(
                '${plan.name} Plan',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            const SizedBox(height: 8),
            if (payment.purchaseDate != null)
              Text(
                'Member since ${payment.purchaseDate!.day}/${payment.purchaseDate!.month}/${payment.purchaseDate!.year}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 32),
            if (plan != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Benefits',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...plan.features.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 20,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Text(f)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlanSelection extends StatelessWidget {
  final PaymentProvider payment;

  const _PlanSelection({required this.payment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock Full Access',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a plan to unlock all practice modules and pass your driving test with confidence.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Plan cards
          ...availablePlans.asMap().entries.map((entry) {
            final index = entry.key;
            final plan = entry.value;
            final isRecommended = index == 1; // Premium plan

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _PlanCard(
                plan: plan,
                isRecommended: isRecommended,
                isProcessing: payment.isProcessing,
                onSelect: () => _purchasePlan(context, plan),
              ),
            );
          }),

          const SizedBox(height: 8),

          // Security note
          Card(
            color: theme.colorScheme.surfaceContainerLow,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Secured by Stripe. Your payment details are encrypted and never stored on our servers.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _purchasePlan(BuildContext context, PremiumPlan plan) async {
    final payment = context.read<PaymentProvider>();
    final success = await payment.purchasePlan(plan);

    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome to ${plan.name}! 🎉'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      } else if (payment.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(payment.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _PlanCard extends StatelessWidget {
  final PremiumPlan plan;
  final bool isRecommended;
  final bool isProcessing;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.plan,
    required this.isRecommended,
    required this.isProcessing,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: isRecommended ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isRecommended
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Column(
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: theme.colorScheme.primary,
              child: Text(
                'RECOMMENDED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plan.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          plan.formattedPrice,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          plan.id.contains('lifetime') ? 'one-time' : '/month',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  plan.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 24),
                // Features
                ...plan.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: isRecommended
                      ? FilledButton(
                          onPressed: isProcessing ? null : onSelect,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isProcessing
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Get ${plan.name}'),
                        )
                      : OutlinedButton(
                          onPressed: isProcessing ? null : onSelect,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isProcessing
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: theme.colorScheme.primary,
                                  ),
                                )
                              : Text('Get ${plan.name}'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
