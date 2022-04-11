import 'dart:async';

import 'error_or_type_error.dart';

/// A result type with either a [value] or an [error].
abstract class ErrorOr<T> {
  /// Create an [ErrorOr] instance of type [_ValueWrapper] given a value.
  const factory ErrorOr.value(T value) = _ValueWrapper<T>;

  /// Create an [ErrorOr] instance of type [_ErrorWrapper] given an error.
  const factory ErrorOr.error(Object error) = _ErrorWrapper<T>;

  /// Try a function [throwing] and return an [ErrorOr] with either a value or
  /// an error, based on whether an exception was thrown or not.
  static FutureOr<ErrorOr<T>> tryIt<T>(FutureOr<T> Function() throwing) async {
    try {
      return ErrorOr.value(await throwing());
    } catch (e) {
      return ErrorOr.error(e);
    }
  }

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
  const _ValueWrapper(this._value);
}

/// A subclass of [ErrorOr] for wrapping an error [Object].
class _ErrorWrapper<T> with ErrorOr<T> {
  /// The [error] of this [ErrorOr].
  final Object _error;

  /// Creates a new [_ErrorWrapper] with the given [error].
  const _ErrorWrapper(this._error);
}
