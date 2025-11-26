/// Local data source for guest data with mock data matching screenshots
/// This data source provides mock guest data that exactly matches the content
/// visible in the provided guest book interface screenshots.
library;

import '../models/guest_model.dart';

/// Abstract interface for local guest data source operations
abstract class GuestLocalDataSource {
  /// Retrieve all guests from local storage
  Future<List<GuestModel>> getAllGuests();

  /// Retrieve a specific guest by ID
  Future<GuestModel?> getGuestById(String id);

  /// Search guests by name or email
  Future<List<GuestModel>> searchGuests(String query);

  /// Add a new guest
  Future<void> addGuest(GuestModel guest);

  /// Update an existing guest
  Future<void> updateGuest(GuestModel guest);

  /// Delete a guest
  Future<void> deleteGuest(String id);

  /// Clear all guests (for testing purposes)
  Future<void> clearAllGuests();
}

/// Implementation of local guest data source with mock data
/// This implementation provides realistic mock data that matches
/// the guest information visible in the interface screenshots
class GuestLocalDataSourceImpl implements GuestLocalDataSource {
  /// In-memory storage for guest data (simulates local database)
  final List<GuestModel> _guests = [];

  /// Flag to track if mock data has been initialized
  bool _isInitialized = false;

  /// Initialize the data source with mock data matching screenshots
  Future<void> _initializeMockData() async {
    if (_isInitialized) return;

    // Mock data extracted from screenshots with realistic variations
    _guests.addAll([
      // Lia Thomas - Exact match from screenshots
      GuestModel(
        id: '1',
        name: 'Lia Thomas',
        email: 'lia.thomas51@reddit.com',
        phone: '+1 212-456-7890',
        loyaltyNumber: 'RF',
        avatarUrl: 'https://i.pravatar.cc/150?text=Lia+Thomas',
        customerSince: DateTime(2023, 6, 15),
        birthday: DateTime(1990, 4, 12),
        averageSpend: 0.0,
        lifetimeSpend: 0.0,
        totalOrders: 0,
        averageTip: 0.0,
        loyaltyEarned: 0,
        loyaltyRedeemed: 0,
        loyaltyAvailable: 0.0,
        loyaltyAmount: 0,
        totalVisits: 0,
        upcomingVisits: 0,
        cancelledVisits: 0,
        noShows: 0,
        allergies: [],
        notes: {},
        tags: [],
      ),

      // Bergnaum - From screenshots guest list
      GuestModel(
        id: '2',
        name: 'Bergnaum',
        email: 'cleorahills@gmail.com',
        phone: '+1 212-450-7890',
        loyaltyNumber: 'BG',
        customerSince: DateTime(2023, 3, 20),
        birthday: DateTime(1985, 8, 25),
        averageSpend: 85.50,
        lifetimeSpend: 342.00,
        totalOrders: 4,
        averageTip: 15.25,
        loyaltyEarned: 34,
        loyaltyRedeemed: 0,
        loyaltyAvailable: 34.0,
        loyaltyAmount: 34,
        totalVisits: 4,
        upcomingVisits: 1,
        cancelledVisits: 0,
        noShows: 0,
        allergies: ['Shellfish'],
        notes: {
          'general': 'Prefers window seating',
          'seatingPreferences': 'Window table, quiet area',
        },
        tags: ['Regular', 'Allergies'],
        lastVisit: DateTime(2024, 11, 10),
      ),

      // Wunderlich - From screenshots guest list
      GuestModel(
        id: '3',
        name: 'Wunderlich',
        email: 'wunder@gmail.com',
        phone: '+1 212-236-7890',
        loyaltyNumber: 'WL',
        customerSince: DateTime(2023, 1, 10),
        birthday: DateTime(1978, 12, 3),
        averageSpend: 125.75,
        lifetimeSpend: 1257.50,
        totalOrders: 10,
        averageTip: 22.50,
        loyaltyEarned: 125,
        loyaltyRedeemed: 25,
        loyaltyAvailable: 100.0,
        loyaltyAmount: 100,
        totalVisits: 10,
        upcomingVisits: 0,
        cancelledVisits: 1,
        noShows: 0,
        allergies: [],
        notes: {
          'general': 'Enjoys wine pairings',
          'specialRelation': 'Anniversary regular - married here',
        },
        tags: ['VIP', 'Wine Lover'],
        lastVisit: DateTime(2024, 11, 5),
      ),

      // Arjun Gerhold - From screenshots guest list
      GuestModel(
        id: '4',
        name: 'Arjun Gerhold',
        email: 'ajashan@user.com',
        phone: '+1 122-456-7890',
        loyaltyNumber: 'AG',
        customerSince: DateTime(2023, 8, 5),
        birthday: DateTime(1992, 2, 18),
        averageSpend: 67.25,
        lifetimeSpend: 403.50,
        totalOrders: 6,
        averageTip: 12.80,
        loyaltyEarned: 40,
        loyaltyRedeemed: 10,
        loyaltyAvailable: 30.0,
        loyaltyAmount: 30,
        totalVisits: 6,
        upcomingVisits: 2,
        cancelledVisits: 0,
        noShows: 1,
        allergies: ['Nuts', 'Dairy'],
        notes: {
          'general': 'Tech industry professional',
          'allergies': 'Severe nut allergy - EpiPen required',
          'seatingPreferences': 'Booth preferred for privacy',
        },
        tags: ['Allergies', 'Business'],
        lastVisit: DateTime(2024, 10, 28),
      ),

      // Simeon Wilderman - From screenshots guest list
      GuestModel(
        id: '5',
        name: 'Simeon Wilderman',
        email: 'simeon@user.com',
        phone: '+1 287-456-7890',
        loyaltyNumber: 'SW',
        customerSince: DateTime(2023, 9, 12),
        birthday: DateTime(1988, 7, 9),
        averageSpend: 95.00,
        lifetimeSpend: 475.00,
        totalOrders: 5,
        averageTip: 18.00,
        loyaltyEarned: 47,
        loyaltyRedeemed: 0,
        loyaltyAvailable: 47.0,
        loyaltyAmount: 47,
        totalVisits: 5,
        upcomingVisits: 1,
        cancelledVisits: 0,
        noShows: 0,
        allergies: [],
        notes: {
          'general': 'Photographer - often brings clients',
          'specialNote': 'Prefers dim lighting for ambiance',
        },
        tags: ['Creative', 'Business Client'],
        lastVisit: DateTime(2024, 11, 1),
      ),

      // Eden Kautzer - From screenshots guest list
      GuestModel(
        id: '6',
        name: 'Eden Kautzer',
        email: 'edenka@user.com',
        phone: '+1 212-456-7090',
        loyaltyNumber: 'EK',
        customerSince: DateTime(2023, 4, 22),
        birthday: DateTime(1995, 11, 30),
        averageSpend: 52.75,
        lifetimeSpend: 316.50,
        totalOrders: 6,
        averageTip: 10.50,
        loyaltyEarned: 31,
        loyaltyRedeemed: 5,
        loyaltyAvailable: 26.0,
        loyaltyAmount: 26,
        totalVisits: 6,
        upcomingVisits: 0,
        cancelledVisits: 2,
        noShows: 1,
        allergies: ['Gluten'],
        notes: {
          'general': 'Student - budget conscious',
          'allergies': 'Celiac disease - strict gluten-free required',
          'seatingPreferences': 'Casual seating area',
        },
        tags: ['Student', 'Gluten-Free', 'Budget'],
        lastVisit: DateTime(2024, 10, 15),
      ),

      // Gino Yost - From screenshots guest list
      GuestModel(
        id: '7',
        name: 'Gino Yost',
        email: 'gyost@test.com',
        phone: '+1 222-456-7890',
        loyaltyNumber: 'GY',
        customerSince: DateTime(2023, 2, 8),
        birthday: DateTime(1980, 5, 14),
        averageSpend: 145.25,
        lifetimeSpend: 1742.00,
        totalOrders: 12,
        averageTip: 28.75,
        loyaltyEarned: 174,
        loyaltyRedeemed: 50,
        loyaltyAvailable: 124.0,
        loyaltyAmount: 124,
        totalVisits: 12,
        upcomingVisits: 1,
        cancelledVisits: 0,
        noShows: 0,
        allergies: [],
        notes: {
          'general': 'Food blogger and critic',
          'specialRelation': 'Influential food reviewer',
          'specialNote': 'VIP treatment - comp desserts occasionally',
        },
        tags: ['VIP', 'Food Critic', 'Influencer'],
        lastVisit: DateTime(2024, 11, 8),
      ),

      // Ayden Veum - From screenshots guest list
      GuestModel(
        id: '8',
        name: 'Ayden Veum',
        email: 'ayden@off@red.com',
        phone: '+1 212-456-7890',
        loyaltyNumber: 'AV',
        customerSince: DateTime(2023, 7, 30),
        birthday: DateTime(1987, 3, 21),
        averageSpend: 78.90,
        lifetimeSpend: 473.40,
        totalOrders: 6,
        averageTip: 14.25,
        loyaltyEarned: 47,
        loyaltyRedeemed: 15,
        loyaltyAvailable: 32.0,
        loyaltyAmount: 32,
        totalVisits: 6,
        upcomingVisits: 0,
        cancelledVisits: 1,
        noShows: 0,
        allergies: ['Seafood'],
        notes: {
          'general': 'Works in marketing',
          'allergies': 'Mild seafood allergy - avoid shellfish',
        },
        tags: ['Marketing', 'Allergies'],
        lastVisit: DateTime(2024, 10, 20),
      ),

      // Additional guests to create a more realistic dataset
      GuestModel(
        id: '9',
        name: 'Maria Rodriguez',
        email: 'maria.r@email.com',
        phone: '+1 555-123-4567',
        loyaltyNumber: 'MR',
        customerSince: DateTime(2023, 5, 15),
        birthday: DateTime(1989, 9, 8),
        averageSpend: 92.50,
        lifetimeSpend: 555.00,
        totalOrders: 6,
        averageTip: 17.50,
        loyaltyEarned: 55,
        loyaltyRedeemed: 20,
        loyaltyAvailable: 35.0,
        loyaltyAmount: 35,
        totalVisits: 6,
        upcomingVisits: 1,
        cancelledVisits: 0,
        noShows: 0,
        allergies: [],
        notes: {
          'general': 'Celebrates here monthly with family',
          'seatingPreferences': 'Large table for family gatherings',
        },
        tags: ['Family', 'Regular'],
        lastVisit: DateTime(2024, 11, 3),
      ),

      GuestModel(
        id: '10',
        name: 'James Chen',
        email: 'j.chen@business.com',
        phone: '+1 555-987-6543',
        loyaltyNumber: 'JC',
        customerSince: DateTime(2023, 1, 5),
        birthday: DateTime(1983, 6, 12),
        averageSpend: 210.00,
        lifetimeSpend: 2520.00,
        totalOrders: 12,
        averageTip: 42.00,
        loyaltyEarned: 252,
        loyaltyRedeemed: 100,
        loyaltyAvailable: 152.0,
        loyaltyAmount: 152,
        totalVisits: 12,
        upcomingVisits: 1,
        cancelledVisits: 0,
        noShows: 0,
        allergies: [],
        notes: {
          'general': 'Executive - frequent business dinners',
          'specialRelation': 'Corporate account holder',
          'seatingPreferences': 'Private dining room for meetings',
        },
        tags: ['VIP', 'Business', 'Corporate'],
        lastVisit: DateTime(2024, 11, 12),
      ),
    ]);

    _isInitialized = true;
  }

  @override
  Future<List<GuestModel>> getAllGuests() async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return List.from(_guests);
  }

  @override
  Future<GuestModel?> getGuestById(String id) async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 150));

    try {
      return _guests.firstWhere((guest) => guest.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<GuestModel>> searchGuests(String query) async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    if (query.trim().isEmpty) {
      return List.from(_guests);
    }

    final lowercaseQuery = query.toLowerCase();
    return _guests
        .where(
          (guest) =>
              guest.name.toLowerCase().contains(lowercaseQuery) ||
              guest.email.toLowerCase().contains(lowercaseQuery),
        )
        .toList();
  }

  @override
  Future<void> addGuest(GuestModel guest) async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 250));

    _guests.add(guest);
  }

  @override
  Future<void> updateGuest(GuestModel guest) async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 250));

    final index = _guests.indexWhere((g) => g.id == guest.id);
    if (index != -1) {
      _guests[index] = guest;
    }
  }

  @override
  Future<void> deleteGuest(String id) async {
    await _initializeMockData();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    _guests.removeWhere((guest) => guest.id == id);
  }

  @override
  Future<void> clearAllGuests() async {
    _guests.clear();
    _isInitialized = false;
  }

  /// Get guests with upcoming visits (helper method)
  Future<List<GuestModel>> getGuestsWithUpcomingVisits() async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 200));

    return _guests.where((guest) => guest.upcomingVisits > 0).toList();
  }

  /// Get top spending guests (helper method)
  Future<List<GuestModel>> getTopSpendingGuests({int limit = 10}) async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 200));

    final sortedGuests = List<GuestModel>.from(_guests)
      ..sort((a, b) => b.lifetimeSpend.compareTo(a.lifetimeSpend));

    return sortedGuests.take(limit).toList();
  }

  /// Get guests with allergies (helper method)
  Future<List<GuestModel>> getGuestsWithAllergies() async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 200));

    return _guests.where((guest) => guest.allergies.isNotEmpty).toList();
  }

  /// Get total guest count (helper method)
  Future<int> getTotalGuestCount() async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 100));

    return _guests.length;
  }

  /// Get total lifetime spending (helper method)
  Future<double> getTotalLifetimeSpending() async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 100));

    return _guests.fold<double>(0.0, (sum, guest) => sum + guest.lifetimeSpend);
  }

  /// Get average spending per guest (helper method)
  Future<double> getAverageSpendingPerGuest() async {
    await _initializeMockData();

    await Future.delayed(const Duration(milliseconds: 100));

    if (_guests.isEmpty) return 0.0;

    final totalSpending = await getTotalLifetimeSpending();
    return totalSpending / _guests.length;
  }
}
