/// Base failure classes for error handling throughout the application
/// These classes represent different types of failures that can occur
/// following Clean Architecture principles with functional error handling.
library;

import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the application
/// This class provides a consistent interface for error handling
/// and supports functional programming patterns with dartz Either
abstract class Failure extends Equatable {
  /// Error message describing what went wrong
  final String message;

  /// Error code for programmatic error handling
  final String code;

  /// Additional context or details about the failure
  final Map<String, dynamic>? details;

  /// Creates a new Failure instance
  const Failure({
    required this.message,
    required this.code,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, details];

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}

// ========== DATA LAYER FAILURES ==========

/// Failure that occurs when data source is unavailable or unreachable
class DataSourceFailure extends Failure {
  const DataSourceFailure({
    required super.message,
    super.code = 'DATA_SOURCE_ERROR',
    super.details,
  });
}

/// Failure that occurs when requested data is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code = 'NOT_FOUND',
    super.details,
  });
}

/// Failure that occurs during data parsing or serialization
class ParseFailure extends Failure {
  const ParseFailure({
    required super.message,
    super.code = 'PARSE_ERROR',
    super.details,
  });
}

/// Failure that occurs during caching operations
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code = 'CACHE_ERROR',
    super.details,
  });
}

// ========== NETWORK FAILURES ==========

/// Failure that occurs when network connection is unavailable
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code = 'NETWORK_ERROR',
    super.details,
  });
}

/// Failure that occurs when server returns an error response
class ServerFailure extends Failure {
  /// HTTP status code from server response
  final int? statusCode;

  const ServerFailure({
    required super.message,
    super.code = 'SERVER_ERROR',
    super.details,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, code, details, statusCode];
}

/// Failure that occurs when request times out
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required super.message,
    super.code = 'TIMEOUT_ERROR',
    super.details,
  });
}

// ========== VALIDATION FAILURES ==========

/// Failure that occurs when input data is invalid
class ValidationFailure extends Failure {
  /// Field names that failed validation
  final List<String>? fields;

  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
    this.fields,
  });

  @override
  List<Object?> get props => [message, code, details, fields];
}

/// Failure that occurs when user lacks permission for an operation
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code = 'PERMISSION_ERROR',
    super.details,
  });
}

/// Failure that occurs when user is not authenticated
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

// ========== BUSINESS LOGIC FAILURES ==========

/// Failure that occurs when business rules are violated
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure({
    required super.message,
    super.code = 'BUSINESS_LOGIC_ERROR',
    super.details,
  });
}

/// Failure that occurs when a resource conflict exists
class ConflictFailure extends Failure {
  const ConflictFailure({
    required super.message,
    super.code = 'CONFLICT_ERROR',
    super.details,
  });
}

/// Failure that occurs when operation is not supported
class UnsupportedOperationFailure extends Failure {
  const UnsupportedOperationFailure({
    required super.message,
    super.code = 'UNSUPPORTED_OPERATION',
    super.details,
  });
}

// ========== SYSTEM FAILURES ==========

/// Failure that occurs due to unexpected system errors
class SystemFailure extends Failure {
  /// Original exception that caused the failure (if available)
  final Object? originalException;

  /// Stack trace for debugging
  final StackTrace? stackTrace;

  const SystemFailure({
    required super.message,
    super.code = 'SYSTEM_ERROR',
    super.details,
    this.originalException,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [
        message,
        code,
        details,
        originalException,
        stackTrace,
      ];
}

/// Failure that occurs when operation is cancelled
class CancellationFailure extends Failure {
  const CancellationFailure({
    required super.message,
    super.code = 'OPERATION_CANCELLED',
    super.details,
  });
}

// ========== PREDEFINED COMMON FAILURES ==========

/// Common failure instances for frequently occurring errors
class CommonFailures {
  // Private constructor to prevent instantiation
  CommonFailures._();

  /// Network connection not available
  static const networkUnavailable = NetworkFailure(
    message: 'Network connection is not available. Please check your internet connection.',
  );

  /// Server temporarily unavailable
  static const serverUnavailable = ServerFailure(
    message: 'Server is temporarily unavailable. Please try again later.',
    statusCode: 503,
  );

  /// Request timed out
  static const requestTimeout = TimeoutFailure(
    message: 'Request timed out. Please try again.',
  );

  /// Data not found
  static const dataNotFound = NotFoundFailure(
    message: 'Requested data could not be found.',
  );

  /// Invalid input data
  static const invalidInput = ValidationFailure(
    message: 'The provided input data is invalid.',
  );

  /// Unexpected system error
  static const unexpectedError = SystemFailure(
    message: 'An unexpected error occurred. Please try again.',
  );

  /// Operation was cancelled
  static const operationCancelled = CancellationFailure(
    message: 'Operation was cancelled by the user.',
  );

  /// Insufficient permissions
  static const insufficientPermissions = PermissionFailure(
    message: 'You do not have permission to perform this operation.',
  );

  /// User not authenticated
  static const notAuthenticated = AuthenticationFailure(
    message: 'Please log in to continue.',
  );
}

// ========== FAILURE FACTORY ==========

/// Factory class for creating specific failure instances
class FailureFactory {
  // Private constructor to prevent instantiation
  FailureFactory._();

  /// Create a network failure with specific message
  static NetworkFailure network(String message) {
    return NetworkFailure(message: message);
  }

  /// Create a server failure with status code
  static ServerFailure server(String message, int statusCode) {
    return ServerFailure(
      message: message,
      statusCode: statusCode,
    );
  }

  /// Create a validation failure with field information
  static ValidationFailure validation(
    String message, {
    List<String>? fields,
  }) {
    return ValidationFailure(
      message: message,
      fields: fields,
    );
  }

  /// Create a not found failure for specific resource
  static NotFoundFailure notFound(String resourceType, String identifier) {
    return NotFoundFailure(
      message: '$resourceType with identifier "$identifier" was not found.',
      details: {
        'resourceType': resourceType,
        'identifier': identifier,
      },
    );
  }

  /// Create a system failure from exception
  static SystemFailure fromException(
    Object exception, {
    StackTrace? stackTrace,
    String? customMessage,
  }) {
    return SystemFailure(
      message: customMessage ?? 'An unexpected error occurred: ${exception.toString()}',
      originalException: exception,
      stackTrace: stackTrace,
    );
  }
}
