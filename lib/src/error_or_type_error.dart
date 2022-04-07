/// An [TypeError] which is thrown if trying to access the value or error of
/// [ErrorOr] and it's the wrong type.
class ErrorOrTypeError extends TypeError {
  /// The error [message].
  final String message;

  /// Creates a new [ErrorOrTypeError] with the given [message].
  ErrorOrTypeError(this.message) : super();

  @override
  String toString() => message;
}
