/// Thrown if trying to access `error` or `value` and the [ErrorOr] is not of
/// the correct type.
class ErrorOrTypeError extends TypeError {
  /// The error [message].
  final String message;

  /// Creates a new [ErrorOrTypeError] with the given [message].
  ErrorOrTypeError(this.message) : super();

  @override
  String toString() => message;
}
