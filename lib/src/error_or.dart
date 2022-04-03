/// A class for holding either an [Error] or a [T] value.
abstract class ErrorOr<T> {
  const ErrorOr._();

  /// Returns true if [Result] is [Success].
  bool get hasValue => this is Success<T>;

  /// Returns true if [Result] is [Failure].
  bool get hasError => this is Failure<T>;

  /// Returns the value [T] if [Success] or throws [ErrorOrTypeCastError].
  T get value {
    if (this is Success<T>) {
      return (this as Success<T>)._value;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasValue] before accessing [value]',
    );
  }

  /// Returns the error [Object] if [Failure] or throws [ErrorOrTypeCastError].
  Object get error {
    if (this is Failure<T>) {
      return (this as Failure<T>)._error;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasError] before accessing [error]',
    );
  }
}

/// The success version of [ErrorOr] for holding a [T] value.
class Success<T> extends ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T _value;

  /// Creates a new [Success] result.
  const Success(T value)
      : _value = value,
        super._();
}

/// The failure version of [ErrorOr] for holding an [Object] error.
class Failure<T> extends ErrorOr<T> {
  /// The error of this [ErrorOr].
  final Object _error;

  /// Creates a new [Failure] with the given [error].
  const Failure(Object error)
      : _error = error,
        super._();
}

/// Thrown if trying to access value or error if wrong type.
class ErrorOrTypeCastError extends Error {
  final String message;

  ErrorOrTypeCastError(this.message) : super();

  @override
  String toString() => message;
}
