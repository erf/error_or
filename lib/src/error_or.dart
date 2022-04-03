class ErrorOr<T> {
  final T? value;
  final Object? error;

  const ErrorOr._({this.value, this.error});

  const ErrorOr.value(T value) : this._(value: value);

  const ErrorOr.error(Object error) : this._(error: error);

  bool get hasValue => value != null;

  bool get hasError => error != null;
}
