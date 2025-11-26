/// Guest model for data layer serialization and deserialization
/// This model extends the domain Guest entity and adds JSON conversion capabilities
/// following Clean Architecture principles.
library;

import '../../domain/entities/guest_entity.dart';

/// Guest model that extends the domain entity with serialization capabilities
/// This model handles the conversion between JSON data and the domain entity
class GuestModel extends Guest {
  /// Creates a new GuestModel instance
  const GuestModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.avatarUrl,
    super.loyaltyNumber,
    super.customerSince,
    super.birthday,
    super.anniversary,
    super.lastVisit,
    super.averageSpend,
    super.lifetimeSpend,
    super.totalOrders,
    super.averageTip,
    super.loyaltyEarned,
    super.loyaltyRedeemed,
    super.loyaltyAvailable,
    super.loyaltyAmount,
    super.totalVisits,
    super.upcomingVisits,
    super.cancelledVisits,
    super.noShows,
    super.allergies,
    super.notes,
    super.tags,
    super.isActive,
  });

  /// Create a GuestModel from a domain Guest entity
  factory GuestModel.fromEntity(Guest guest) {
    return GuestModel(
      id: guest.id,
      name: guest.name,
      email: guest.email,
      phone: guest.phone,
      avatarUrl: guest.avatarUrl,
      loyaltyNumber: guest.loyaltyNumber,
      customerSince: guest.customerSince,
      birthday: guest.birthday,
      anniversary: guest.anniversary,
      lastVisit: guest.lastVisit,
      averageSpend: guest.averageSpend,
      lifetimeSpend: guest.lifetimeSpend,
      totalOrders: guest.totalOrders,
      averageTip: guest.averageTip,
      loyaltyEarned: guest.loyaltyEarned,
      loyaltyRedeemed: guest.loyaltyRedeemed,
      loyaltyAvailable: guest.loyaltyAvailable,
      loyaltyAmount: guest.loyaltyAmount,
      totalVisits: guest.totalVisits,
      upcomingVisits: guest.upcomingVisits,
      cancelledVisits: guest.cancelledVisits,
      noShows: guest.noShows,
      allergies: guest.allergies,
      notes: guest.notes,
      tags: guest.tags,
      isActive: guest.isActive,
    );
  }

  /// Create a GuestModel from JSON data
  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      loyaltyNumber: json['loyaltyNumber'] as String?,
      customerSince: json['customerSince'] != null
          ? DateTime.parse(json['customerSince'] as String)
          : null,
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'] as String)
          : null,
      anniversary: json['anniversary'] != null
          ? DateTime.parse(json['anniversary'] as String)
          : null,
      lastVisit: json['lastVisit'] != null
          ? DateTime.parse(json['lastVisit'] as String)
          : null,
      averageSpend: (json['averageSpend'] as num?)?.toDouble() ?? 0.0,
      lifetimeSpend: (json['lifetimeSpend'] as num?)?.toDouble() ?? 0.0,
      totalOrders: json['totalOrders'] as int? ?? 0,
      averageTip: (json['averageTip'] as num?)?.toDouble() ?? 0.0,
      loyaltyEarned: json['loyaltyEarned'] as int? ?? 0,
      loyaltyRedeemed: json['loyaltyRedeemed'] as int? ?? 0,
      loyaltyAvailable: (json['loyaltyAvailable'] as num?)?.toDouble() ?? 0.0,
      loyaltyAmount: json['loyaltyAmount'] as int? ?? 0,
      totalVisits: json['totalVisits'] as int? ?? 0,
      upcomingVisits: json['upcomingVisits'] as int? ?? 0,
      cancelledVisits: json['cancelledVisits'] as int? ?? 0,
      noShows: json['noShows'] as int? ?? 0,
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'] as List)
          : const [],
      notes: json['notes'] != null
          ? Map<String, String>.from(json['notes'] as Map)
          : const {},
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : const [],
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert GuestModel to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'loyaltyNumber': loyaltyNumber,
      'customerSince': customerSince?.toIso8601String(),
      'birthday': birthday?.toIso8601String(),
      'anniversary': anniversary?.toIso8601String(),
      'lastVisit': lastVisit?.toIso8601String(),
      'averageSpend': averageSpend,
      'lifetimeSpend': lifetimeSpend,
      'totalOrders': totalOrders,
      'averageTip': averageTip,
      'loyaltyEarned': loyaltyEarned,
      'loyaltyRedeemed': loyaltyRedeemed,
      'loyaltyAvailable': loyaltyAvailable,
      'loyaltyAmount': loyaltyAmount,
      'totalVisits': totalVisits,
      'upcomingVisits': upcomingVisits,
      'cancelledVisits': cancelledVisits,
      'noShows': noShows,
      'allergies': allergies,
      'notes': notes,
      'tags': tags,
      'isActive': isActive,
    };
  }

  /// Create a copy of this model with updated values
  GuestModel copyWithModel({
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
    return GuestModel(
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

  /// Convert to domain entity
  Guest toEntity() {
    return Guest(
      id: id,
      name: name,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      loyaltyNumber: loyaltyNumber,
      customerSince: customerSince,
      birthday: birthday,
      anniversary: anniversary,
      lastVisit: lastVisit,
      averageSpend: averageSpend,
      lifetimeSpend: lifetimeSpend,
      totalOrders: totalOrders,
      averageTip: averageTip,
      loyaltyEarned: loyaltyEarned,
      loyaltyRedeemed: loyaltyRedeemed,
      loyaltyAvailable: loyaltyAvailable,
      loyaltyAmount: loyaltyAmount,
      totalVisits: totalVisits,
      upcomingVisits: upcomingVisits,
      cancelledVisits: cancelledVisits,
      noShows: noShows,
      allergies: allergies,
      notes: notes,
      tags: tags,
      isActive: isActive,
    );
  }

  @override
  String toString() {
    return 'GuestModel(id: $id, name: $name, email: $email)';
  }
}
