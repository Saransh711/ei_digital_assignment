/// Implementation of the Guest Repository interface
/// This class bridges the domain layer with the data layer,
/// handling data transformation and error management.
library;

import 'package:dartz/dartz.dart';
import '../../domain/entities/guest_entity.dart';
import '../../domain/repositories/guest_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/guest_local_datasource.dart';
import '../models/guest_model.dart';

/// Concrete implementation of GuestRepository
/// This class implements all guest data operations by delegating to the data source
/// and handling error cases with proper failure types
class GuestRepositoryImpl implements GuestRepository {
  /// Local data source for guest operations
  final GuestLocalDataSource localDataSource;

  /// Creates a new GuestRepositoryImpl instance
  /// 
  /// [localDataSource] The data source implementation for guest data
  const GuestRepositoryImpl({
    required this.localDataSource,
  });

  // ========== READ OPERATIONS ==========

  @override
  Future<Either<Failure, List<Guest>>> getAllGuests() async {
    try {
      final guestModels = await localDataSource.getAllGuests();
      final guests = guestModels.map((model) => model.toEntity()).toList();
      return Right(guests);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests from local storage',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> getGuestById(String id) async {
    try {
      if (id.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Guest ID cannot be empty',
            fields: ['id'],
          ),
        );
      }

      final guestModel = await localDataSource.getGuestById(id);
      
      if (guestModel == null) {
        return Left(FailureFactory.notFound('Guest', id));
      }

      return Right(guestModel.toEntity());
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guest with ID: $id',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> searchGuests(String query) async {
    try {
      if (query.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Search query cannot be empty',
            fields: ['query'],
          ),
        );
      }

      final guestModels = await localDataSource.searchGuests(query);
      final guests = guestModels.map((model) => model.toEntity()).toList();
      return Right(guests);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to search guests with query: $query',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getGuestsWithUpcomingVisits() async {
    try {
      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final guestModels = await dataSource.getGuestsWithUpcomingVisits();
      final guests = guestModels.map((model) => model.toEntity()).toList();
      return Right(guests);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests with upcoming visits',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getGuestsByVisitFrequency(
    VisitFrequency frequency,
  ) async {
    try {
      final allGuestsResult = await getAllGuests();
      
      return allGuestsResult.fold(
        (failure) => Left(failure),
        (guests) {
          final filteredGuests = guests
              .where((guest) => guest.visitFrequency == frequency)
              .toList();
          return Right(filteredGuests);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests by visit frequency',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getGuestsBySpendingCategory(
    SpendingCategory category,
  ) async {
    try {
      final allGuestsResult = await getAllGuests();
      
      return allGuestsResult.fold(
        (failure) => Left(failure),
        (guests) {
          final filteredGuests = guests
              .where((guest) => guest.spendingCategory == category)
              .toList();
          return Right(filteredGuests);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests by spending category',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getGuestsWithAllergies() async {
    try {
      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final guestModels = await dataSource.getGuestsWithAllergies();
      final guests = guestModels.map((model) => model.toEntity()).toList();
      return Right(guests);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to retrieve guests with allergies',
        ),
      );
    }
  }

  // ========== WRITE OPERATIONS ==========

  @override
  Future<Either<Failure, Guest>> addGuest(Guest guest) async {
    try {
      // Validate guest data
      final validation = _validateGuestData(guest);
      if (validation != null) {
        return Left(validation);
      }

      final guestModel = GuestModel.fromEntity(guest);
      await localDataSource.addGuest(guestModel);
      return Right(guest);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to add guest',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> updateGuest(Guest guest) async {
    try {
      // Validate guest data
      final validation = _validateGuestData(guest);
      if (validation != null) {
        return Left(validation);
      }

      // Check if guest exists
      final existingResult = await getGuestById(guest.id);
      if (existingResult.isLeft()) {
        return Left(FailureFactory.notFound('Guest', guest.id));
      }

      final guestModel = GuestModel.fromEntity(guest);
      await localDataSource.updateGuest(guestModel);
      return Right(guest);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to update guest',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteGuest(String id) async {
    try {
      if (id.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Guest ID cannot be empty',
            fields: ['id'],
          ),
        );
      }

      // Check if guest exists
      final existingResult = await getGuestById(id);
      if (existingResult.isLeft()) {
        return Left(FailureFactory.notFound('Guest', id));
      }

      await localDataSource.deleteGuest(id);
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to delete guest',
        ),
      );
    }
  }

  // ========== STATISTICS OPERATIONS ==========

  @override
  Future<Either<Failure, int>> getTotalGuestCount() async {
    try {
      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final count = await dataSource.getTotalGuestCount();
      return Right(count);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to get total guest count',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getTotalLifetimeSpending() async {
    try {
      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final totalSpending = await dataSource.getTotalLifetimeSpending();
      return Right(totalSpending);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to get total lifetime spending',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getAverageSpendingPerGuest() async {
    try {
      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final averageSpending = await dataSource.getAverageSpendingPerGuest();
      return Right(averageSpending);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to get average spending per guest',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getTopSpendingGuests({
    int limit = 10,
  }) async {
    try {
      if (limit <= 0) {
        return const Left(
          ValidationFailure(
            message: 'Limit must be greater than 0',
            fields: ['limit'],
          ),
        );
      }

      final dataSource = localDataSource as GuestLocalDataSourceImpl;
      final guestModels = await dataSource.getTopSpendingGuests(limit: limit);
      final guests = guestModels.map((model) => model.toEntity()).toList();
      return Right(guests);
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to get top spending guests',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Guest>>> getMostFrequentVisitors({
    int limit = 10,
  }) async {
    try {
      if (limit <= 0) {
        return const Left(
          ValidationFailure(
            message: 'Limit must be greater than 0',
            fields: ['limit'],
          ),
        );
      }

      final allGuestsResult = await getAllGuests();
      
      return allGuestsResult.fold(
        (failure) => Left(failure),
        (guests) {
          final sortedGuests = List<Guest>.from(guests)
            ..sort((a, b) => b.totalVisits.compareTo(a.totalVisits));
          
          final topVisitors = sortedGuests.take(limit).toList();
          return Right(topVisitors);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to get most frequent visitors',
        ),
      );
    }
  }

  // ========== NOTES AND PREFERENCES OPERATIONS ==========

  @override
  Future<Either<Failure, Guest>> updateGuestNotes(
    String guestId,
    String category,
    String notes,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedNotes = Map<String, String>.from(guest.notes);
          updatedNotes[category] = notes;
          
          final updatedGuest = guest.copyWith(notes: updatedNotes);
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to update guest notes',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> addGuestAllergy(
    String guestId,
    String allergy,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          if (guest.allergies.contains(allergy)) {
            return Right(guest); // Already has this allergy
          }
          
          final updatedAllergies = List<String>.from(guest.allergies)
            ..add(allergy);
          
          final updatedGuest = guest.copyWith(allergies: updatedAllergies);
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to add guest allergy',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> removeGuestAllergy(
    String guestId,
    String allergy,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedAllergies = List<String>.from(guest.allergies)
            ..remove(allergy);
          
          final updatedGuest = guest.copyWith(allergies: updatedAllergies);
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to remove guest allergy',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> addGuestTag(
    String guestId,
    String tag,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          if (guest.tags.contains(tag)) {
            return Right(guest); // Already has this tag
          }
          
          final updatedTags = List<String>.from(guest.tags)..add(tag);
          
          final updatedGuest = guest.copyWith(tags: updatedTags);
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to add guest tag',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> removeGuestTag(
    String guestId,
    String tag,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedTags = List<String>.from(guest.tags)..remove(tag);
          
          final updatedGuest = guest.copyWith(tags: updatedTags);
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to remove guest tag',
        ),
      );
    }
  }

  // ========== LOYALTY AND STATISTICS OPERATIONS ==========

  @override
  Future<Either<Failure, Guest>> updateLoyaltyPoints(
    String guestId,
    int pointsEarned,
    int pointsRedeemed,
  ) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedGuest = guest.copyWith(
            loyaltyEarned: guest.loyaltyEarned + pointsEarned,
            loyaltyRedeemed: guest.loyaltyRedeemed + pointsRedeemed,
            loyaltyAmount: guest.loyaltyAmount + pointsEarned - pointsRedeemed,
            loyaltyAvailable: guest.loyaltyAvailable + pointsEarned - pointsRedeemed,
          );
          
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to update loyalty points',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> updateVisitStatistics(
    String guestId, {
    int? totalVisits,
    int? upcomingVisits,
    int? cancelledVisits,
    int? noShows,
    DateTime? lastVisit,
  }) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedGuest = guest.copyWith(
            totalVisits: totalVisits ?? guest.totalVisits,
            upcomingVisits: upcomingVisits ?? guest.upcomingVisits,
            cancelledVisits: cancelledVisits ?? guest.cancelledVisits,
            noShows: noShows ?? guest.noShows,
            lastVisit: lastVisit ?? guest.lastVisit,
          );
          
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to update visit statistics',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Guest>> updateSpendingStatistics(
    String guestId, {
    double? averageSpend,
    double? lifetimeSpend,
    int? totalOrders,
    double? averageTip,
  }) async {
    try {
      final guestResult = await getGuestById(guestId);
      
      return guestResult.fold(
        (failure) => Left(failure),
        (guest) async {
          final updatedGuest = guest.copyWith(
            averageSpend: averageSpend ?? guest.averageSpend,
            lifetimeSpend: lifetimeSpend ?? guest.lifetimeSpend,
            totalOrders: totalOrders ?? guest.totalOrders,
            averageTip: averageTip ?? guest.averageTip,
          );
          
          return updateGuest(updatedGuest);
        },
      );
    } catch (e, stackTrace) {
      return Left(
        FailureFactory.fromException(
          e,
          stackTrace: stackTrace,
          customMessage: 'Failed to update spending statistics',
        ),
      );
    }
  }

  // ========== PRIVATE HELPER METHODS ==========

  /// Validate guest data before operations
  ValidationFailure? _validateGuestData(Guest guest) {
    final errors = <String>[];
    final fields = <String>[];

    if (guest.id.trim().isEmpty) {
      errors.add('Guest ID cannot be empty');
      fields.add('id');
    }

    if (guest.name.trim().isEmpty) {
      errors.add('Guest name cannot be empty');
      fields.add('name');
    }

    if (guest.email.trim().isEmpty) {
      errors.add('Guest email cannot be empty');
      fields.add('email');
    } else if (!_isValidEmail(guest.email)) {
      errors.add('Guest email format is invalid');
      fields.add('email');
    }

    if (guest.phone.trim().isEmpty) {
      errors.add('Guest phone cannot be empty');
      fields.add('phone');
    }

    if (errors.isNotEmpty) {
      return ValidationFailure(
        message: errors.join(', '),
        fields: fields,
      );
    }

    return null;
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }
}
