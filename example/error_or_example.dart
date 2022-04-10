import 'dart:math';

import 'package:error_or/error_or.dart';

Future<ErrorOr<String>> getValueOrError() async {
  await Future.delayed(Duration(milliseconds: 500));
  if (Random().nextBool() == false) {
    return ErrorOr.error(Exception('Error'));
  }
  return ErrorOr.value('Success');
}

void main() async {
  // ErrorOr example
  final errorOr = await getValueOrError();
  if (errorOr.hasError) {
    print(errorOr.error);
    return;
  }
  print(errorOr.value);

  // ErrorOrTypeError example
  try {
    final errorOr = await getValueOrError();
    print(errorOr.value);
  } on ErrorOrTypeError catch (e) {
    print(e.message);
  }
}
