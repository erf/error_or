/// A class for holding either an [Error] or a [T] value.
abstract class ErrorOr<T> {
  const ErrorOr._();

  /// Returns true if [Result] is [Failure].
  bool get isFailure => this is Failure<T>;

  /// Returns true if [Result] is [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns the error [Object] if [Failure].
  Object get failure {
    if (this is Failure<T>) {
      return (this as Failure<T>).error;
    }

    throw Exception(
      'Make sure that result [isFailure] before accessing [failure]',
    );
  }

  /// Returns a new value of [Success] result.
  T get success {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    throw Exception(
      'Make sure that result [isSuccess] before accessing [success]',
    );
  }

  static ErrorOr<T> value<T>(value) {
    return Success(value);
  }

  static ErrorOr<T> error<T>(Object error) {
    return Failure<T>(error);
  }
}

/// The success version of [ErrorOr] for holding a [T] value.
class Success<T> extends ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T value;

  const Success(this.value) : super._();
}

/// The failure version of [ErrorOr] for holding an [Object] error.
class Failure<T> extends ErrorOr<T> {
  /// The error of this [ErrorOr].
  final Object error;

  const Failure(this.error) : super._();
}
