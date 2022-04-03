/// Thrown if trying to access value or error if wrong type.
class ErrorOrTypeCastError extends Error {
  final String message;

  ErrorOrTypeCastError(this.message) : super();

  @override
  String toString() => message;
}
