library error_or;

class ErrorOr<T> {
  final T? value;
  final Object? error;

  const ErrorOr({this.value, this.error});

  const ErrorOr.value(T value) : this(value: value);

  const ErrorOr.error(Object error) : this(error: error);

  bool get hasValue => value != null;

  bool get hasError => error != null;
}
