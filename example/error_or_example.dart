import 'dart:math';

import 'package:error_or/error_or.dart';

Future<ErrorOr<String>> getSuccessOrFailure() async {
  await Future.delayed(Duration(milliseconds: 500));
  if (Random().nextBool() == false) {
    return Failure(Exception('Error'));
  }
  return Success('Success');
}

void main() async {
  final errorOr = await getSuccessOrFailure();
  if (errorOr.hasError) {
    print(errorOr.error);
    return;
  }
  print(errorOr.value);
}
