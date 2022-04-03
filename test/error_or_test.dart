import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorOr tests', () {
    test('add value 1 and expect 1', () {
      const errorOr = ErrorOr.value(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
      expect(errorOr.error, null);
    });

    test('add error and expect it', () {
      final errorOr = ErrorOr.error(Exception('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.value, null);
      expect(errorOr.error, isA<Exception>());
      expect(errorOr.error.toString(), 'Exception: Error');
    });
  });
}
