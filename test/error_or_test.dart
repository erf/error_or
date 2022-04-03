import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorOr tests', () {
    test('Add Success with value 1', () {
      final errorOr = ErrorOr.withValue(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    test('Add Failure with Exception', () {
      final errorOr = ErrorOr.withError(Exception('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<Exception>());
      expect(errorOr.error.toString(), 'Exception: Error');
    });
  });
}
