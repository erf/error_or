/// Thrown if trying to access value or error if wrong type.
class ErrorOrTypeError extends TypeError {
  final String message;

  ErrorOrTypeError(this.message) : super();

  @override
  String toString() => message;
}
