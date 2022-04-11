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

void throwingFunction() {
  throw MyException('MyException');
}

void main() {
  group('ErrorOr test value', () {
    test('Add ErrorOr with value 1', () {
      const errorOr = ErrorOr.value(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
    });

    test('Add ErrorOr with value \'Success\'', () {
      const errorOr = ErrorOr.value('Success');
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 'Success');
    });

    test('Add ErrorOr with value \'Success\'', () {
      const errorOr = ErrorOr.value(MyValueClass('Success'));
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, isA<MyValueClass>());
      expect(errorOr.value.toString(), 'Success');
    });
  });

  group('ErrorOr test error', () {
    test('Add ErrorOr with error Exception', () {
      const errorOr = ErrorOr.error(MyException('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
      expect(errorOr.error.toString(), 'Error');
    });
  });

  group('ErrorOrTypeError', () {
    test('Add value then access error should throw ErrorOrTypeError', () {
      const errorOr = ErrorOr.value(1);
      expect(errorOr.hasValue, true);
      expect(errorOr.hasError, false);
      expect(errorOr.value, 1);
      expect(() => errorOr.error, throwsA(TypeMatcher<ErrorOrTypeError>()));
    });

    test('Add error then access value should throw ErrorOrTypeError', () {
      const errorOr = ErrorOr.error(MyException('Error'));
      expect(errorOr.hasValue, false);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
      expect(errorOr.error.toString(), 'Error');
      expect(() => errorOr.value, throwsA(TypeMatcher<ErrorOrTypeError>()));
    });
  });

  group('tryIt', () {
    test('tryIt with anonymous function throws Exception', () async {
      final errorOr = await ErrorOr.tryIt(() => throw Exception('Error'));
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<Exception>());
    });

    test('tryIt with throwingFunction', () async {
      final errorOr = await ErrorOr.tryIt(throwingFunction);
      expect(errorOr.hasError, true);
      expect(errorOr.error, isA<MyException>());
    });

    test('tryIt with success', () async {
      final errorOr = await ErrorOr.tryIt(() => 'Success');
      expect(errorOr.hasError, false);
      expect(errorOr.hasValue, true);
      expect(errorOr.value, 'Success');
    });
  });
}
