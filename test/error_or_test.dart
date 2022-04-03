import 'package:error_or/error_or.dart';
import 'package:test/test.dart';

class MyException implements Exception {
  final String message;

  const MyException(this.message);

  @override
  String toString() => message;
}

class MyValueClass {
  final String message;

  const MyValueClass(this.message);

  @override
  String toString() => message;
}

void main() {
  group('ErrorOr test value', () {
    test('Add ErrorOr with value 1', () {
      const errorOr = ErrorOr.withValue(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    test('Add ErrorOr with value \'Success\'', () {
      const errorOr = ErrorOr.withValue('Success');
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 'Success');
    });

    test('Add ErrorOr with value \'Success\'', () {
      const errorOr = ErrorOr.withValue(MyValueClass('Success'));
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, isA<MyValueClass>());
      expect(errorOr.value.toString(), 'Success');
    });
  });

  group('ErrorOr test error', () {
    test('Add ErrorOr with error Exception', () {
      const errorOr = ErrorOr.withError(MyException('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
      expect(errorOr.error.toString(), 'Error');
    });
  });

  group('ErrorOr test accessing wrong type', () {
    test('Add value and try to access error should throw exception', () {
      const errorOr = ErrorOr.withValue(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
      expect(() => errorOr.error, throwsA(TypeMatcher<ErrorOrTypeCastError>()));
    });

    test('Add error and try to access value should throw exception', () {
      const errorOr = ErrorOr.withError(MyException('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
      expect(errorOr.error.toString(), 'Error');
      expect(() => errorOr.value, throwsA(TypeMatcher<ErrorOrTypeCastError>()));
    });
  });
}
