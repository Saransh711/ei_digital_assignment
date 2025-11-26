/// Use case for retrieving guests from the repository
/// This use case encapsulates the business logic for fetching guest data
/// and follows Clean Architecture principles with single responsibility.
library;

import 'package:dartz/dartz.dart';
import '../entities/guest_entity.dart';
import '../repositories/guest_repository.dart';
import '../../core/error/failures.dart';

/// Use case for retrieving all guests from the repository
/// This class contains the business logic for guest retrieval operations
/// and serves as an intermediary between the presentation and data layers
class GetGuestsUseCase {
  /// Repository instance for guest data access
  final GuestRepository repository;

  /// Creates a new GetGuestsUseCase instance
  /// 
  /// [repository] The guest repository implementation to use for data access
  const GetGuestsUseCase({required this.repository});

  /// Execute the use case to retrieve all guests
  /// 
  /// Returns [Right] containing a list of guests on success
  /// Returns [Left] containing failure information on error
  /// 
  /// This method handles the core business logic for guest retrieval:
  /// - Fetches all guests from the repository
  /// - Sorts guests by name for consistent display
  /// - Filters out inactive guests (business rule)
  /// - Returns processed guest list
  Future<Either<Failure, List<Guest>>> call() async {
    try {
      // Fetch all guests from repository
      final result = await repository.getAllGuests();
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guests) {
          // Apply business logic: filter active guests and sort by name
          final activeGuests = guests
              .where((guest) => guest.isActive)
              .toList()
            ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          
          return Right(activeGuests);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests',
        ),
      );
    }
  }

  /// Execute the use case to search guests by query
  /// 
  /// [query] Search term to filter guests by name or email
  /// 
  /// Returns [Right] containing filtered list of guests on success
  /// Returns [Left] containing failure information on error
  /// 
  /// This method handles guest search business logic:
  /// - Validates search query
  /// - Performs case-insensitive search
  /// - Searches both name and email fields
  /// - Returns sorted results
  Future<Either<Failure, List<Guest>>> searchGuests(String query) async {
    try {
      // Validate input
      if (query.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Search query cannot be empty',
            fields: ['query'],
          ),
        );
      }

      // Perform search through repository
      final result = await repository.searchGuests(query);
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guests) {
          // Apply business logic: filter active guests and sort by relevance
          final activeGuests = guests
              .where((guest) => guest.isActive)
              .toList()
            ..sort((a, b) {
              // Sort by name match first, then email match
              final aNameMatch = a.name.toLowerCase().contains(query.toLowerCase());
              final bNameMatch = b.name.toLowerCase().contains(query.toLowerCase());
              
              if (aNameMatch && !bNameMatch) return -1;
              if (!aNameMatch && bNameMatch) return 1;
              
              // Both or neither match name, sort alphabetically
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            });
          
          return Right(activeGuests);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to search guests',
        ),
      );
    }
  }

  /// Execute the use case to get a specific guest by ID
  /// 
  /// [guestId] Unique identifier of the guest to retrieve
  /// 
  /// Returns [Right] containing guest data on success
  /// Returns [Left] containing failure information on error
  Future<Either<Failure, Guest>> getGuestById(String guestId) async {
    try {
      // Validate input
      if (guestId.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Guest ID cannot be empty',
            fields: ['guestId'],
          ),
        );
      }

      // Fetch guest from repository
      final result = await repository.getGuestById(guestId);
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guest) {
          // Apply business logic: check if guest is active
          if (!guest.isActive) {
            return Left(
              FailureFactory.notFound('Active guest', guestId),
            );
          }
          
          return Right(guest);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guest',
        ),
      );
    }
  }

  /// Execute the use case to get guests with upcoming visits
  /// 
  /// Returns [Right] containing list of guests with upcoming visits
  /// Returns [Left] containing failure information on error
  /// 
  /// Business logic: Only return active guests who have at least one upcoming visit
  Future<Either<Failure, List<Guest>>> getGuestsWithUpcomingVisits() async {
    try {
      final result = await repository.getGuestsWithUpcomingVisits();
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guests) {
          // Apply business logic: filter active guests with upcoming visits
          final filteredGuests = guests
              .where((guest) => guest.isActive && guest.hasUpcomingVisits)
              .toList()
            ..sort((a, b) => b.upcomingVisits.compareTo(a.upcomingVisits)); // Sort by upcoming visits count
          
          return Right(filteredGuests);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests with upcoming visits',
        ),
      );
    }
  }

  /// Execute the use case to get top spending guests
  /// 
  /// [limit] Maximum number of guests to return (default: 10)
  /// 
  /// Returns [Right] containing list of top spending guests
  /// Returns [Left] containing failure information on error
  Future<Either<Failure, List<Guest>>> getTopSpendingGuests({
    int limit = 10,
  }) async {
    try {
      // Validate input
      if (limit <= 0) {
        return const Left(
          ValidationFailure(
            message: 'Limit must be greater than 0',
            fields: ['limit'],
          ),
        );
      }

      final result = await repository.getTopSpendingGuests(limit: limit);
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guests) {
          // Apply business logic: ensure only active guests with spending > 0
          final filteredGuests = guests
              .where((guest) => guest.isActive && guest.lifetimeSpend > 0)
              .take(limit)
              .toList();
          
          return Right(filteredGuests);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve top spending guests',
        ),
      );
    }
  }

  /// Execute the use case to get guests with allergies
  /// 
  /// Returns [Right] containing list of guests who have allergies
  /// Returns [Left] containing failure information on error
  /// 
  /// Business logic: Only return active guests who have at least one allergy
  Future<Either<Failure, List<Guest>>> getGuestsWithAllergies() async {
    try {
      final result = await repository.getGuestsWithAllergies();
      
      return result.fold(
        // Return failure as-is
        (failure) => Left(failure),
        // Process successful result
        (guests) {
          // Apply business logic: filter active guests with allergies
          final filteredGuests = guests
              .where((guest) => guest.isActive && guest.hasAllergies)
              .toList()
            ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          
          return Right(filteredGuests);
        },
      );
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests with allergies',
        ),
      );
    }
  }

  /// Execute the use case to get guest statistics
  /// 
  /// Returns [Right] containing guest statistics
  /// Returns [Left] containing failure information on error
  Future<Either<Failure, GuestStatistics>> getGuestStatistics() async {
    try {
      // Fetch all required statistics concurrently
      final futures = await Future.wait([
        repository.getTotalGuestCount(),
        repository.getTotalLifetimeSpending(),
        repository.getAverageSpendingPerGuest(),
      ]);

      // Check if any operation failed
      for (final result in futures) {
        if (result.isLeft()) {
          return Left(result.fold((failure) => failure, (_) => throw StateError('Unreachable')));
        }
      }

      // Extract successful values
      final totalCount = futures[0].fold((_) => 0, (count) => count as int);
      final totalSpending = futures[1].fold((_) => 0.0, (amount) => amount as double);
      final averageSpending = futures[2].fold((_) => 0.0, (average) => average as double);

      final statistics = GuestStatistics(
        totalGuests: totalCount,
        totalLifetimeSpending: totalSpending,
        averageSpendingPerGuest: averageSpending,
      );

      return Right(statistics);
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guest statistics',
        ),
      );
    }
  }
}

/// Data class for guest statistics
class GuestStatistics {
  final int totalGuests;
  final double totalLifetimeSpending;
  final double averageSpendingPerGuest;

  const GuestStatistics({
    required this.totalGuests,
    required this.totalLifetimeSpending,
    required this.averageSpendingPerGuest,
  });
}
