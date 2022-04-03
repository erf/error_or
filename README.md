# ErrorOr

A simple package for returning a result with either a value `T` or an error
`Object`.

## Features

Return a value `ErrorOr` from an async function and `await` it without a
`try catch` - and rather do that in the called function.

A subclass of `ErrorOr` contains either the expected value `T` or an error
`Object` (usually an `Exception` returned from a `try catch`).

Internally, we create one of two hidden subbclasses of `ErrorOr`, either a
`_Success` or a `_Failure`, which contains the expected non-null values.

`ErrorOr` can be used for non-async (sync) functions too - for both Flutter and Dart.

## Getting started

Make a function return a `Future<ErrorOr>`, which you'll `await` in the calling
class.

Create a `ErrorOr` type by calling one of its factory methods `withValue` or
`withError`.

Check if `hasError`, before calling `error`, or check if `hasValue` before
calling `value`. If either is called without the proper check, an
`ErrorOrTypeCastError` is thrown.

## Usage

Example

```dart
Future<ErrorOr<LocationPermission>> checkPermission() async {
  try {
    return ErrorOr.withValue(await Geolocator.checkPermission());
  } catch (e) {
    return ErrorOr.withError(e);
  }
}
ErrorOr<LocationPermission> errorOrPermission = await checkPermission();
if (errorOrPermission.hasError) {
	return errorOrPermission;
}
LocationPermission permission = errorOrPermission.value;
```

## Additional information

I would like to keep this package minimal, but please get in touch on github if
you have suggestions to improvements.

The name was inspired by the `ErrorOr` type of [SerenityOS](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h).

The Success / Failure type pattern was inspired by [result_type](https://pub.dev/packages/result_type).