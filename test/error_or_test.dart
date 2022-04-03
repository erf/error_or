import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorOr tests', () {
    test('Add Success with value 1', () {
      const errorOr = Success(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    test('Add Failure with Exception', () {
      final errorOr = Failure(Exception('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<Exception>());
      expect(errorOr.error.toString(), 'Exception: Error');
    });

    ErrorOr<int> getSuccess() {
      return Success(1);
    }

    test('Call function which returns Success', () {
      final errorOr = getSuccess();
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    ErrorOr<int> getFailure() {
      return Failure(Exception('Error'));
    }

    test('Call function which returns Failure', () {
      final errorOr = getFailure();
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<Exception>());
    });
  });
}
