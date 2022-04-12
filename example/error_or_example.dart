import 'dart:async';
import 'dart:math';

import 'package:error_or/error_or.dart';

String maybeThrows() {
  if (Random().nextBool() == false) {
    throw Exception('Error');
  }
  return 'Success';
}

ErrorOr<String> maybeErrorSync() {
  if (Random().nextBool() == false) {
    return ErrorOr.error(Exception('Error'));
  }
  return ErrorOr.value('Success');
}

final delay = Duration(milliseconds: 400);

Future<String> getValueOrThrows() async {
  await Future.delayed(delay);
  return maybeThrows();
}

Future<ErrorOr<String>> getValueOrError() async {
  await Future.delayed(delay);
  return ErrorOr.wrap(maybeThrows);
}

Future<void> errorHandlingWithThenAndCatchError() async {
  print('* Error handling with then and catchError');
  final completer = Completer();
  getValueOrThrows().then((String value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    print('');
    completer.complete();
  });
  return completer.future;
}

Future<void> errorHandlingWithAwaitAndTryCatch() async {
  print('* Error handling with await and try/catch');
  try {
    final String value = await getValueOrThrows();
    print(value);
  } catch (e) {
    print(e);
  }
  print('');
}

Future<void> errorHandlingWithErrorOr() async {
  print('* Error handling with ErrorOr');
  final ErrorOr<String> errorOr = await getValueOrError();
  if (errorOr.hasError) {
    print(errorOr.error);
  } else {
    print(errorOr.value);
  }
  print('');
}

void errorHandlingWithErrorOrSync() {
  print('* Error handling with ErrorOr sync');
  final ErrorOr<String> errorOr = maybeErrorSync();
  if (errorOr.hasError) {
    print(errorOr.error);
  } else {
    print(errorOr.value);
  }
  print('');
}

Future<void> errorHandlingWithErrorOrTypeError() async {
  print('* Error handling with ErrorOr throws ErrorOrTypeError');
  try {
    final ErrorOr<String> errorOr = await getValueOrError();
    print(errorOr.value);
  } on ErrorOrTypeError catch (e) {
    print(e.message);
  }
  print('');
}

void main() async {
  await errorHandlingWithThenAndCatchError();
  await errorHandlingWithAwaitAndTryCatch();
  await errorHandlingWithErrorOr();
  errorHandlingWithErrorOrSync();
  await errorHandlingWithErrorOrTypeError();
}
