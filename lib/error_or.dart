library error_or;

class ErrorOr<T> {
  final T? value;
  final Object? error;

  const ErrorOr({this.value, this.error});

  factory ErrorOr.value(T value) => ErrorOr(value: value);

  factory ErrorOr.error(Object error) => ErrorOr(error: error);

  bool get hasValue => value != null;

  bool get hasError => error != null;
}
