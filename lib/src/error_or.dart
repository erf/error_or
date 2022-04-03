import 'error_or_type_cast_error.dart';

/// The base class for either a [_Success] or [_Failure] instance.
///
/// In addition to factory classes for creating [_Success] and [_Failure]
/// instances, this class provides getters and setters for the [value] and
/// [error] properties of these subclasses, and also type checks.
abstract class ErrorOr<T> {
  const ErrorOr._();

  // Create an [ErrorO] instance of type [_Success] given a value.
  const factory ErrorOr.withValue(T value) = _Success<T>;

  // Create an [ErrorO] instance of type [_Failure] given an error.
  const factory ErrorOr.withError(Object error) = _Failure<T>;

  /// Returns true if [Result] is [_Success].
  bool get hasValue => this is _Success<T>;

  /// Returns true if [Result] is [_Failure].
  bool get hasError => this is _Failure<T>;

  /// Returns the value [T] if [_Success] or throws [ErrorOrTypeCastError].
  T get value {
    if (this is _Success<T>) {
      return (this as _Success<T>)._value;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasValue] before accessing [value]',
    );
  }

  /// Returns the error [Object] if [_Failure] or throws [ErrorOrTypeCastError].
  Object get error {
    if (this is _Failure<T>) {
      return (this as _Failure<T>)._error;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasError] before accessing [error]',
    );
  }
}

/// The success version of [ErrorOr] for holding a [T] value.
class _Success<T> extends ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T _value;

  /// Creates a new [_Success] result.
  const _Success(T value)
      : _value = value,
        super._();
}

/// The failure version of [ErrorOr] for holding an [Object] error.
class _Failure<T> extends ErrorOr<T> {
  /// The error of this [ErrorOr].
  final Object _error;

  /// Creates a new [_Failure] with the given [error].
  const _Failure(Object error)
      : _error = error,
        super._();
}
