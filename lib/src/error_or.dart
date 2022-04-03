import 'error_or_type_cast_error.dart';

/// [ErrorOr] is the base class for either [_ValueWrapper] or [_ErrorWrapper].
///
/// In addition to factory constructors for creating [_ValueWrapper] and
/// [_ErrorWrapper] instances, [ErrorOr] provides getters and setters for the
/// [value] and [error] properties of its subclasses, and also type checks.
abstract class ErrorOr<T> {
  const ErrorOr._();

  /// Create an [ErrorOr] instance of type [_ValueWrapper] given a value.
  const factory ErrorOr.withValue(T value) = _ValueWrapper<T>;

  /// Create an [ErrorOr] instance of type [_ErrorWrapper] given an error.
  const factory ErrorOr.withError(Object error) = _ErrorWrapper<T>;

  /// Returns true if [Result] is [_ValueWrapper].
  bool get hasValue => this is _ValueWrapper<T>;

  /// Returns true if [Result] is [_ErrorWrapper].
  bool get hasError => this is _ErrorWrapper<T>;

  /// Returns the value [T] if [_ValueWrapper] or throws [ErrorOrTypeCastError].
  T get value {
    if (this is _ValueWrapper<T>) {
      return (this as _ValueWrapper<T>)._value;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasValue] before accessing [value]',
    );
  }

  /// Returns the error [Object] if [_ErrorWrapper] or throws [ErrorOrTypeCastError].
  Object get error {
    if (this is _ErrorWrapper<T>) {
      return (this as _ErrorWrapper<T>)._error;
    }
    throw ErrorOrTypeCastError(
      'Make sure that result [hasError] before accessing [error]',
    );
  }
}

/// A [ErrorOr] type for holding a value [T].
class _ValueWrapper<T> extends ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T _value;

  /// Creates a new [_ValueWrapper] result.
  const _ValueWrapper(T value)
      : _value = value,
        super._();
}

/// A [ErrorOr] type for wrapping an error [Object].
class _ErrorWrapper<T> extends ErrorOr<T> {
  /// The error of this [ErrorOr].
  final Object _error;

  /// Creates a new [_ErrorWrapper] with the given [error].
  const _ErrorWrapper(Object error)
      : _error = error,
        super._();
}
