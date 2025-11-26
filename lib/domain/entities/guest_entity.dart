/// Guest entity representing a guest in the guest book system
/// This is a pure business object that contains no dependencies
/// on external frameworks or data sources.
library;

import 'package:equatable/equatable.dart';

/// Guest entity containing all guest information and statistics
/// This entity represents the core business object for the guest book application
class Guest extends Equatable {
  /// Creates a new Guest instance
  const Guest({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.loyaltyNumber,
    this.customerSince,
    this.birthday,
    this.anniversary,
    this.lastVisit,
    this.averageSpend = 0.0,
    this.lifetimeSpend = 0.0,
    this.totalOrders = 0,
    this.averageTip = 0.0,
    this.loyaltyEarned = 0,
    this.loyaltyRedeemed = 0,
    this.loyaltyAvailable = 0.0,
    this.loyaltyAmount = 0,
    this.totalVisits = 0,
    this.upcomingVisits = 0,
    this.cancelledVisits = 0,
    this.noShows = 0,
    this.allergies = const [],
    this.notes = const {},
    this.tags = const [],
    this.isActive = true,
  });

  // ========== BASIC INFORMATION ==========

  /// Unique identifier for the guest
  final String id;

  /// Full name of the guest
  final String name;

  /// Email address of the guest
  final String email;

  /// Phone number of the guest
  final String phone;

  /// URL to the guest's avatar image (optional)
  final String? avatarUrl;

  /// Loyalty program number (optional)
  final String? loyaltyNumber;

  /// Date when the guest became a customer
  final DateTime? customerSince;

  /// Guest's birthday
  final DateTime? birthday;

  /// Guest's anniversary date
  final DateTime? anniversary;

  // ========== VISIT STATISTICS ==========

  /// Date of the guest's last visit
  final DateTime? lastVisit;

  /// Average amount spent per visit
  final double averageSpend;

  /// Total lifetime spending
  final double lifetimeSpend;

  /// Total number of orders placed
  final int totalOrders;

  /// Average tip amount
  final double averageTip;

  // ========== LOYALTY PROGRAM ==========

  /// Total loyalty points earned
  final int loyaltyEarned;

  /// Total loyalty points redeemed
  final int loyaltyRedeemed;

  /// Available loyalty balance (monetary value)
  final double loyaltyAvailable;

  /// Available loyalty points amount
  final int loyaltyAmount;

  // ========== VISIT METRICS ==========

  /// Total number of visits
  final int totalVisits;

  /// Number of upcoming visits
  final int upcomingVisits;

  /// Number of cancelled visits
  final int cancelledVisits;

  /// Number of no-shows
  final int noShows;

  // ========== PREFERENCES & NOTES ==========

  /// List of guest allergies
  final List<String> allergies;

  /// Map of note categories to note content
  /// Categories: 'general', 'specialRelation', 'seatingPreferences', 'specialNote', 'allergies'
  final Map<String, String> notes;

  /// List of tags associated with the guest
  final List<String> tags;

  /// Whether the guest is active in the system
  final bool isActive;

  // ========== COMPUTED PROPERTIES ==========

  /// Get guest's initials for avatar display
  String get initials {
    if (name.isEmpty) return '?';

    final names = name.trim().split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 1).toUpperCase();
    }

    return '${names.first.substring(0, 1)}${names.last.substring(0, 1)}'
        .toUpperCase();
  }

  /// Get first name only
  String get firstName {
    final names = name.trim().split(' ');
    return names.isNotEmpty ? names.first : name;
  }

  /// Get last name only
  String get lastName {
    final names = name.trim().split(' ');
    return names.length > 1 ? names.last : '';
  }

  /// Check if guest has any allergies
  bool get hasAllergies => allergies.isNotEmpty;

  /// Check if guest has upcoming visits
  bool get hasUpcomingVisits => upcomingVisits > 0;

  /// Check if guest has made any orders
  bool get hasOrders => totalOrders > 0;

  /// Get formatted customer since duration
  String get customerDuration {
    if (customerSince == null) return 'New Customer';

    final now = DateTime.now();
    final difference = now.difference(customerSince!);

    if (difference.inDays < 30) {
      return '${difference.inDays} days';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months != 1 ? 's' : ''}';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years != 1 ? 's' : ''}';
    }
  }

  /// Get visit frequency category
  VisitFrequency get visitFrequency {
    if (totalVisits >= 50) return VisitFrequency.veryFrequent;
    if (totalVisits >= 20) return VisitFrequency.frequent;
    if (totalVisits >= 10) return VisitFrequency.regular;
    if (totalVisits >= 5) return VisitFrequency.occasional;
    return VisitFrequency.rare;
  }

  /// Get spending category
  SpendingCategory get spendingCategory {
    if (lifetimeSpend >= 5000) return SpendingCategory.vip;
    if (lifetimeSpend >= 2000) return SpendingCategory.high;
    if (lifetimeSpend >= 500) return SpendingCategory.medium;
    if (lifetimeSpend > 0) return SpendingCategory.low;
    return SpendingCategory.none;
  }

  // ========== METHODS ==========

  /// Create a copy of this guest with updated values
  Guest copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    String? loyaltyNumber,
    DateTime? customerSince,
    DateTime? birthday,
    DateTime? anniversary,
    DateTime? lastVisit,
    double? averageSpend,
    double? lifetimeSpend,
    int? totalOrders,
    double? averageTip,
    int? loyaltyEarned,
    int? loyaltyRedeemed,
    double? loyaltyAvailable,
    int? loyaltyAmount,
    int? totalVisits,
    int? upcomingVisits,
    int? cancelledVisits,
    int? noShows,
    List<String>? allergies,
    Map<String, String>? notes,
    List<String>? tags,
    bool? isActive,
  }) {
    return Guest(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      loyaltyNumber: loyaltyNumber ?? this.loyaltyNumber,
      customerSince: customerSince ?? this.customerSince,
      birthday: birthday ?? this.birthday,
      anniversary: anniversary ?? this.anniversary,
      lastVisit: lastVisit ?? this.lastVisit,
      averageSpend: averageSpend ?? this.averageSpend,
      lifetimeSpend: lifetimeSpend ?? this.lifetimeSpend,
      totalOrders: totalOrders ?? this.totalOrders,
      averageTip: averageTip ?? this.averageTip,
      loyaltyEarned: loyaltyEarned ?? this.loyaltyEarned,
      loyaltyRedeemed: loyaltyRedeemed ?? this.loyaltyRedeemed,
      loyaltyAvailable: loyaltyAvailable ?? this.loyaltyAvailable,
      loyaltyAmount: loyaltyAmount ?? this.loyaltyAmount,
      totalVisits: totalVisits ?? this.totalVisits,
      upcomingVisits: upcomingVisits ?? this.upcomingVisits,
      cancelledVisits: cancelledVisits ?? this.cancelledVisits,
      noShows: noShows ?? this.noShows,
      allergies: allergies ?? this.allergies,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    avatarUrl,
    loyaltyNumber,
    customerSince,
    birthday,
    anniversary,
    lastVisit,
    averageSpend,
    lifetimeSpend,
    totalOrders,
    averageTip,
    loyaltyEarned,
    loyaltyRedeemed,
    loyaltyAvailable,
    loyaltyAmount,
    totalVisits,
    upcomingVisits,
    cancelledVisits,
    noShows,
    allergies,
    notes,
    tags,
    isActive,
  ];

  @override
  String toString() {
    return 'Guest(id: $id, name: $name, email: $email)';
  }
}

/// Enumeration for visit frequency categories
enum VisitFrequency { rare, occasional, regular, frequent, veryFrequent }

/// Extension for visit frequency display names
extension VisitFrequencyExtension on VisitFrequency {
  String get displayName {
    switch (this) {
      case VisitFrequency.rare:
        return 'Rare Visitor';
      case VisitFrequency.occasional:
        return 'Occasional Visitor';
      case VisitFrequency.regular:
        return 'Regular Visitor';
      case VisitFrequency.frequent:
        return 'Frequent Visitor';
      case VisitFrequency.veryFrequent:
        return 'VIP Visitor';
    }
  }
}

/// Enumeration for spending categories
enum SpendingCategory { none, low, medium, high, vip }

/// Extension for spending category display names
extension SpendingCategoryExtension on SpendingCategory {
  String get displayName {
    switch (this) {
      case SpendingCategory.none:
        return 'New Customer';
      case SpendingCategory.low:
        return 'Light Spender';
      case SpendingCategory.medium:
        return 'Regular Spender';
      case SpendingCategory.high:
        return 'High Value';
      case SpendingCategory.vip:
        return 'VIP Customer';
    }
  }
}
