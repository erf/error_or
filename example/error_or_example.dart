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

void main() async {
  // ErrorOr example
  final errorOr = await getValueOrError();
  if (errorOr.hasError) {
    print(errorOr.error);
  } else {
    print(errorOr.value);
  }

  // ErrorOrTypeError example
  try {
    final errorOr = await getValueOrError();
    print(errorOr.value);
  } on ErrorOrTypeError catch (e) {
    print(e.message);
  }
}
