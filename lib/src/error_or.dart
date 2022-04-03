/// A class for holding either an [Error] or a [T] value.
abstract class ErrorOr<T> {
  const ErrorOr._();

  /// Returns true if [Result] is [Success].
  bool get hasValue => this is Success<T>;

  /// Returns true if [Result] is [Failure].
  bool get hasError => this is Failure<T>;

  /// Returns a new value of [Success] result.
  T get value {
    if (this is Success<T>) {
      return (this as Success<T>)._value;
    }
    throw ErrorOrTypeCheckError(
      'Make sure that result [isSuccess] before accessing [success]',
    );
  }

  /// Returns the error [Object] if [Failure].
  Object get error {
    if (this is Failure<T>) {
      return (this as Failure<T>)._error;
    }
    throw ErrorOrTypeCheckError(
      'Make sure that result [isFailure] before accessing [failure]',
    );
  }
}

/// The success version of [ErrorOr] for holding a [T] value.
class Success<T> extends ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T _value;

  const Success(T value)
      : _value = value,
        super._();
}

/// The failure version of [ErrorOr] for holding an [Object] error.
class Failure<T> extends ErrorOr<T> {
  /// The error of this [ErrorOr].
  final Object _error;

  const Failure(Object error)
      : _error = error,
        super._();
}

class ErrorOrTypeCheckError extends Error {
  final String message;

  ErrorOrTypeCheckError(this.message) : super();

  @override
  String toString() => message;
}
