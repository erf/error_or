import 'error_or_type_error.dart';

/// [ErrorOr] is the base class for [_ValueWrapper] and [_ErrorWrapper].
///
/// In addition to factory constructors for creating mentioned subclasses,
/// [ErrorOr] provides, type check methods [hasValue] and [hasError] and getters
/// and setters for the [value] and [error] properties of its subclasses.
abstract class ErrorOr<T> {
  /// Create an [ErrorOr] instance of type [_ValueWrapper] given a value.
  const factory ErrorOr.value(T value) = _ValueWrapper<T>;

  /// Create an [ErrorOr] instance of type [_ErrorWrapper] given an error.
  const factory ErrorOr.error(Object error) = _ErrorWrapper<T>;

  /// Returns true if [ErrorOr] is a [_ValueWrapper].
  bool get hasValue => this is _ValueWrapper<T>;

  /// Returns true if [ErrorOr] is a [_ErrorWrapper].
  bool get hasError => this is _ErrorWrapper<T>;

  /// Return the value [T] of [_ValueWrapper] or throws [ErrorOrTypeError] if
  /// [ErrorOr] is not a [_ValueWrapper].
  T get value {
    if (this is _ValueWrapper<T>) {
      return (this as _ValueWrapper<T>)._value;
    }
    throw ErrorOrTypeError('Check [hasValue] before accessing [value]');
  }

  /// Return the error [Object] of [_ErrorWrapper] or throws [ErrorOrTypeError]
  /// if [ErrorOr] is not a [_ErrorWrapper].
  Object get error {
    if (this is _ErrorWrapper<T>) {
      return (this as _ErrorWrapper<T>)._error;
    }
    throw ErrorOrTypeError('Check [hasError] before accessing [error]');
  }
}

/// A subclass of [ErrorOr] for wrapping a value [T].
class _ValueWrapper<T> with ErrorOr<T> {
  /// The [_value] of this [ErrorOr].
  final T _value;

  /// Creates a new [_ValueWrapper] with a given [value].
  const _ValueWrapper(T value) : _value = value;
}

/// A subclass of [ErrorOr] for wrapping an error [Object].
class _ErrorWrapper<T> with ErrorOr<T> {
  /// The [error] of this [ErrorOr].
  final Object _error;

  /// Creates a new [_ErrorWrapper] with the given [error].
  const _ErrorWrapper(Object error) : _error = error;
}
