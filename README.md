# ErrorOr

Return a result `ErrorOr` with either a value `T` or an error `Object`.

## Features

Always return a valid value `ErrorOr` from an async function. Let the called /
inner function handle the error and return an `ErrorOr`. This way the caller /
outer function can `await` the result without a `try catch`.

A subclass of `ErrorOr` contains either the expected value `T` or an error
`Object` (usually an `Exception` returned from a `try catch`).

Internally, we create a private subclass of `ErrorOr`, either a `_ValueWrapper`
or an `_ErrorWrapper`, with the expected non-null value.

`ErrorOr` can be used for non-async functions too - for both Flutter and Dart.

## Getting started

Make a function return a `Future<ErrorOr>`, which you'll `await` in the calling
function.

Create a `ErrorOr` instance by calling one of its factory methods `withValue` or
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

The Success / Failure pattern was inspired by [result_type](https://pub.dev/packages/result_type).