class PremiumPlan {
  final String id;
  final String name;
  final String description;
  final int priceInPence;
  final List<String> features;

  const PremiumPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.priceInPence,
    required this.features,
  });

  String get formattedPrice {
    final pounds = priceInPence ~/ 100;
    final pence = priceInPence % 100;
    return '£$pounds.${pence.toString().padLeft(2, '0')}';
  }
}

const List<PremiumPlan> availablePlans = [
  PremiumPlan(
    id: 'basic_monthly',
    name: 'Basic',
    description: 'Monthly access to theory tests',
    priceInPence: 299,
    features: [
      'Unlimited theory test practice',
      'Detailed answer explanations',
      'Progress tracking',
    ],
  ),
  PremiumPlan(
    id: 'premium_monthly',
    name: 'Premium',
    description: 'Full access to all modules',
    priceInPence: 599,
    features: [
      'Everything in Basic',
      'Hazard perception clips',
      'Virtual driving scenarios',
      'Priority support',
    ],
  ),
  PremiumPlan(
    id: 'ultimate_lifetime',
    name: 'Ultimate',
    description: 'One-time lifetime access',
    priceInPence: 1499,
    features: [
      'Everything in Premium',
      'Lifetime access — pay once',
      'All future content updates',
      'Mock exam simulations',
    ],
  ),
];
