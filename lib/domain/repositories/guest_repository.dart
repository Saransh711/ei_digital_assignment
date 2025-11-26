/// Abstract repository interface for guest data operations
/// This interface defines the contract for guest data access
/// following Clean Architecture principles - no implementation details here.
library;

import 'package:dartz/dartz.dart';
import '../entities/guest_entity.dart';
import '../../core/error/failures.dart';

/// Repository interface for guest data operations
/// This abstract class defines all guest-related data operations
/// without specifying how the data is stored or retrieved
abstract class GuestRepository {
  
  // ========== READ OPERATIONS ==========

  /// Retrieve all guests from the data source
  /// Returns [Right] with list of guests on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getAllGuests();

  /// Retrieve a specific guest by their unique identifier
  /// Returns [Right] with guest data on success
  /// Returns [Left] with failure information if guest not found or error occurs
  Future<Either<Failure, Guest>> getGuestById(String id);

  /// Search guests by name or email
  /// Returns [Right] with filtered list of guests on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> searchGuests(String query);

  /// Get guests with upcoming visits
  /// Returns [Right] with list of guests who have upcoming visits
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getGuestsWithUpcomingVisits();

  /// Get guests by visit frequency
  /// Returns [Right] with filtered list based on visit frequency
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getGuestsByVisitFrequency(
    VisitFrequency frequency,
  );

  /// Get guests by spending category
  /// Returns [Right] with filtered list based on spending category
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getGuestsBySpendingCategory(
    SpendingCategory category,
  );

  /// Get guests with allergies
  /// Returns [Right] with list of guests who have allergies
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getGuestsWithAllergies();

  // ========== WRITE OPERATIONS ==========

  /// Add a new guest to the data source
  /// Returns [Right] with created guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> addGuest(Guest guest);

  /// Update an existing guest's information
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> updateGuest(Guest guest);

  /// Delete a guest from the data source
  /// Returns [Right] with success indicator on completion
  /// Returns [Left] with failure information on error
  Future<Either<Failure, void>> deleteGuest(String id);

  // ========== STATISTICS OPERATIONS ==========

  /// Get total number of guests in the system
  /// Returns [Right] with count on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, int>> getTotalGuestCount();

  /// Get total lifetime spending across all guests
  /// Returns [Right] with total amount on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, double>> getTotalLifetimeSpending();

  /// Get average spending per guest
  /// Returns [Right] with average amount on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, double>> getAverageSpendingPerGuest();

  /// Get top spending guests
  /// Returns [Right] with list of top spenders (limited by count)
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getTopSpendingGuests({
    int limit = 10,
  });

  /// Get most frequent visitors
  /// Returns [Right] with list of frequent visitors (limited by count)
  /// Returns [Left] with failure information on error
  Future<Either<Failure, List<Guest>>> getMostFrequentVisitors({
    int limit = 10,
  });

  // ========== NOTES AND PREFERENCES OPERATIONS ==========

  /// Update guest notes for a specific category
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> updateGuestNotes(
    String guestId,
    String category,
    String notes,
  );

  /// Add allergy information for a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> addGuestAllergy(
    String guestId,
    String allergy,
  );

  /// Remove allergy information for a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> removeGuestAllergy(
    String guestId,
    String allergy,
  );

  /// Add tag to a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> addGuestTag(
    String guestId,
    String tag,
  );

  /// Remove tag from a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> removeGuestTag(
    String guestId,
    String tag,
  );

  // ========== LOYALTY OPERATIONS ==========

  /// Update loyalty points for a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> updateLoyaltyPoints(
    String guestId,
    int pointsEarned,
    int pointsRedeemed,
  );

  /// Update visit statistics for a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> updateVisitStatistics(
    String guestId, {
    int? totalVisits,
    int? upcomingVisits,
    int? cancelledVisits,
    int? noShows,
    DateTime? lastVisit,
  });

  /// Update spending statistics for a guest
  /// Returns [Right] with updated guest on success
  /// Returns [Left] with failure information on error
  Future<Either<Failure, Guest>> updateSpendingStatistics(
    String guestId, {
    double? averageSpend,
    double? lifetimeSpend,
    int? totalOrders,
    double? averageTip,
  });
}
