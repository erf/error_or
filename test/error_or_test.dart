import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorOr tests', () {
    test('Add Success with value 1', () {
      const errorOr = Success(1);
      expect(errorOr.isSuccess, true);
      expect(errorOr.isFailure, false);
      expect(errorOr.value, 1);
    });

    test('Add Failure with Exception', () {
      final errorOr = Failure(Exception('Error'));
      expect(errorOr.isSuccess, false);
      expect(errorOr.isFailure, true);
      expect(errorOr.error, isA<Exception>());
      expect(errorOr.error.toString(), 'Exception: Error');
    });

    ErrorOr<int> getSuccess() {
      return Success(1);
    }

    test('Call function which returs ErrorOr and check if success', () {
      final errorOr = getSuccess();
      expect(errorOr.isSuccess, true);
      expect(errorOr.isFailure, false);
      expect(errorOr.success, 1);
    });
  });
}
