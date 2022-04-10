import 'dart:math';

import 'package:error_or/error_or.dart';

String maybeThrows() {
  if (Random().nextBool() == false) {
    throw Exception('Error');
  }
  return 'Success';
}

Future<ErrorOr<String>> getValueOrError() async {
  await Future.delayed(Duration(milliseconds: 500));
  try {
    return ErrorOr.value(maybeThrows());
  } catch (e) {
    return ErrorOr.error(e);
  }
}

Future<String> getValueOrThrows() async {
  await Future.delayed(Duration(milliseconds: 500));
  return maybeThrows();
}

void main() async {
  // ErrorOr example
  print('* ErrorOr example');
  final errorOr = await getValueOrError();
  if (errorOr.hasError) {
    print(errorOr.error);
  } else {
    print(errorOr.value);
  }
  print('');

  // ErrorOrTypeError example
  print('* ErrorOrTypeError example');
  try {
    final errorOr = await getValueOrError();
    print(errorOr.value);
  } on ErrorOrTypeError catch (e) {
    print(e.message);
  }
  print('');

  // Normal Error handling with await and try/catch
  print('* Normal Error handling with await and try/catch');
  try {
    final value = await getValueOrThrows();
    print(value);
  } on Exception catch (e) {
    print(e);
  }
  print('');

  // Normal Error handling with then and catchError
  print('* Normal Error handling with then and catchError');
  getValueOrThrows().then((value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    print('');
  });
}
