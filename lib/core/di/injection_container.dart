/// Dependency injection container configuration using get_it
/// This file sets up all the dependencies for the Clean Architecture layers
/// ensuring proper separation of concerns and testability.
library;

import 'package:get_it/get_it.dart';

import '../../data/datasources/guest_local_datasource.dart';
// Data layer imports
import '../../data/repositories/guest_repository_impl.dart';
// Domain layer imports
import '../../domain/repositories/guest_repository.dart';
import '../../domain/usecases/get_guests_usecase.dart';
// Presentation layer imports
import '../../presentation/bloc/guest_list_bloc/guest_list_bloc.dart';
import '../../presentation/bloc/panel_bloc/panel_bloc.dart';
import '../../presentation/bloc/tab_bloc/tab_bloc.dart';

/// Service locator instance
/// This is the single global instance used throughout the application
final GetIt sl = GetIt.instance;

/// Initialize all dependencies for the application
/// This function should be called once during app initialization
/// before any other code tries to resolve dependencies
Future<void> initializeDependencies() async {
  try {
    // ========== DATA SOURCES ==========

    /// Register local data source as singleton
    /// Single instance used throughout the app for consistency
    sl.registerLazySingleton<GuestLocalDataSource>(
      () => GuestLocalDataSourceImpl(),
    );

    // ========== REPOSITORIES ==========

    /// Register repository implementation as singleton
    /// Uses the registered data source to provide a single point of data access
    sl.registerLazySingleton<GuestRepository>(
      () => GuestRepositoryImpl(localDataSource: sl<GuestLocalDataSource>()),
    );

    // ========== USE CASES ==========

    /// Register use cases as lazy singletons
    /// Use cases contain business logic and should be reused across the app
    sl.registerLazySingleton<GetGuestsUseCase>(
      () => GetGuestsUseCase(repository: sl<GuestRepository>()),
    );

    // ========== BLOCS ==========

    /// Register BLoCs as factories to create new instances
    /// Each widget that uses a BLoC should get its own instance
    /// to maintain proper state isolation

    /// Guest List BLoC factory
    /// Creates a new instance each time it's requested
    sl.registerFactory<GuestListBloc>(
      () => GuestListBloc(getGuestsUseCase: sl<GetGuestsUseCase>()),
    );

    /// Panel BLoC factory
    /// Creates a new instance each time it's requested
    /// Manages the left panel collapse/expand state
    sl.registerFactory<PanelBloc>(() => PanelBloc());

    /// Tab BLoC factory
    /// Creates a new instance each time it's requested
    /// Manages tab selection in detail panel
    sl.registerFactory<TabBloc>(() => TabBloc());

    // ========== EXTERNAL DEPENDENCIES ==========
    // (None for this application as it's frontend-only with mock data)
  } catch (e) {
    // Re-throw with more context
    throw DependencyInjectionException(
      'Failed to initialize dependencies during startup',
      originalException: e,
    );
  }
}

/// Helper function to check if dependencies are initialized
/// Useful for testing and debugging
bool get isDependenciesInitialized {
  try {
    // Try to resolve a core dependency to check if container is set up
    sl<GuestRepository>();
    return true;
  } catch (e) {
    return false;
  }
}

/// Reset all dependencies
/// Useful for testing scenarios where you need a clean state
Future<void> resetDependencies() async {
  await sl.reset();
}

/// Register additional test dependencies
/// Used in testing to inject mock implementations
void registerTestDependencies() {
  // This function can be used in tests to override dependencies
  // with mock implementations. For now, it's empty as we're using
  // the real implementations with mock data.

  // Example usage in tests:
  // sl.registerSingleton<GuestRepository>(MockGuestRepository());
}

// ========== CONVENIENCE GETTERS ==========

/// These getters provide easy access to commonly used dependencies
/// They help reduce boilerplate when resolving dependencies

/// Get the guest repository instance
GuestRepository get guestRepository => sl<GuestRepository>();

/// Get the get guests use case instance
GetGuestsUseCase get getGuestsUseCase => sl<GetGuestsUseCase>();

/// Create a new guest list bloc instance
GuestListBloc createGuestListBloc() => sl<GuestListBloc>();

/// Create a new panel bloc instance
PanelBloc createPanelBloc() => sl<PanelBloc>();

/// Create a new tab bloc instance
TabBloc createTabBloc() => sl<TabBloc>();

// ========== ERROR HANDLING ==========

/// Custom exception for dependency injection errors
class DependencyInjectionException implements Exception {
  final String message;
  final Object? originalException;

  const DependencyInjectionException(this.message, {this.originalException});

  @override
  String toString() {
    if (originalException != null) {
      return 'DependencyInjectionException: $message (caused by: $originalException)';
    }
    return 'DependencyInjectionException: $message';
  }
}

/// Safe dependency resolution with error handling
/// Returns null if dependency cannot be resolved instead of throwing
T? safeResolve<T extends Object>() {
  try {
    return sl<T>();
  } catch (e) {
    // Log error in production app
    // For now, just return null
    return null;
  }
}

/// Resolve dependency with custom error handling
/// Throws DependencyInjectionException with context if resolution fails
T resolveOrThrow<T extends Object>(String contextMessage) {
  try {
    return sl<T>();
  } catch (e) {
    throw DependencyInjectionException(
      'Failed to resolve ${T.toString()}: $contextMessage',
      originalException: e,
    );
  }
}

// ========== SCOPE MANAGEMENT ==========

/// Dependency scopes for better lifetime management
/// These help organize dependencies by their intended lifecycle

class DependencyScopes {
  static const String core = 'core';
  static const String feature = 'feature';
  static const String ui = 'ui';

  // Private constructor to prevent instantiation
  DependencyScopes._();
}

/// Register core dependencies (data sources, repositories, use cases)
/// These are the fundamental dependencies that other layers depend on
Future<void> _registerCoreDependencies() async {
  // Data sources - singleton for consistent data access
  sl.registerLazySingleton<GuestLocalDataSource>(
    () => GuestLocalDataSourceImpl(),
  );

  // Repositories - singleton to ensure single source of truth
  sl.registerLazySingleton<GuestRepository>(
    () => GuestRepositoryImpl(localDataSource: sl<GuestLocalDataSource>()),
  );

  // Use cases - singleton as they're stateless business logic
  sl.registerLazySingleton<GetGuestsUseCase>(
    () => GetGuestsUseCase(repository: sl<GuestRepository>()),
  );
}

/// Register UI dependencies (BLoCs, view models)
/// These are factory-scoped to provide fresh instances per widget
Future<void> _registerUIDependencies() async {
  // BLoCs - factory scope for proper state isolation
  sl.registerFactory<GuestListBloc>(
    () => GuestListBloc(getGuestsUseCase: sl<GetGuestsUseCase>()),
  );

  sl.registerFactory<PanelBloc>(() => PanelBloc());

  sl.registerFactory<TabBloc>(() => TabBloc());
}

/// Initialize dependencies in proper order
/// Core dependencies first, then UI dependencies that depend on them
Future<void> initializeInOrder() async {
  await _registerCoreDependencies();
  await _registerUIDependencies();
}

/// Verify all critical dependencies are properly registered
/// Useful for startup validation
void validateDependencies() {
  final criticalDependencies = [
    GuestLocalDataSource,
    GuestRepository,
    GetGuestsUseCase,
  ];

  for (final dependencyType in criticalDependencies) {
    try {
      sl.get(type: dependencyType);
    } catch (e) {
      throw DependencyInjectionException(
        'Critical dependency $dependencyType is not registered',
        originalException: e,
      );
    }
  }
}
