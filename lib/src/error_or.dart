/// A class for holding either an [Error] or a [T] value.
class ErrorOr<T> {
  /// The value of this [ErrorOr].
  final T? value;

  /// The error of this [ErrorOr].
  final Object? error;

  /// Creates a new [ErrorOr] with the given [value] and [error].
  const ErrorOr._({this.value, this.error});

  /// Creates a new [ErrorOr] with the given [value].
  const ErrorOr.value(T value) : this._(value: value);

  /// Creates a new [ErrorOr] with the given [error].
  const ErrorOr.error(Object error) : this._(error: error);

  /// Return true if this [ErrorOr] has a value.
  bool get hasValue => value != null;

  /// Return true if this [ErrorOr] has an error.
  bool get hasError => error != null;
}
