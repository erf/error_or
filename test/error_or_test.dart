import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

class MyException implements Exception {
  final String message;

  const MyException(this.message);

  @override
  String toString() => message;
}

void main() {
  group('ErrorOr tests', () {
    test('Add Success with value 1', () {
      const errorOr = ErrorOr.withValue(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    test('Add Success with value \'Success\'', () {
      const errorOr = ErrorOr.withValue('Success');
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 'Success');
    });

    test('Add Failure with Exception', () {
      const errorOr = ErrorOr.withError(MyException('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
      expect(errorOr.error.toString(), 'Error');
    });
  });
}
