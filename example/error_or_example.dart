import 'dart:math';

import 'package:error_or/error_or.dart';

Future<ErrorOr<String>> getValue() async {
  await Future.delayed(Duration(seconds: 1));
  if (Random().nextBool() == false) {
    return ErrorOr.error(Exception('Error'));
  }
  return ErrorOr.value('Success');
}

void main() async {
  final errorOr = await getValue();
  if (errorOr.hasError) {
    print(errorOr.error);
    return;
  }
  print(errorOr.value);
}
