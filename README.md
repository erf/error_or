# ErrorOr

A simple class `ErrorOr` for returning a result with either a value `T` or an
error `Object`.

## Features

Always return a value `ErrorOr` from an async function and `await` it without a
`try catch` - rather do that in the called function.

There are other result type packages, but i wanted something simple. `ErrorOr` 
returns either the expected value, or an error `Object`, usually an `Exception` 
returned from a `try catch` error.

Internally, we create one of two subbclasses of `ErrorOr`, either a `_Success`
or a `_Failure`, which contains the expected non-null values.

`ErrorOr` can be used for sync functions too.

## Getting started

Make a function return an `ErrorOr` or a `Future<ErrorOr>`, which you'll `await`
in the calling class.

Create a new `ErrorOr` subbclass by calling one of its factory methods `withValue`
or `withError`.

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
LocationPermission permission = errorOrPermission.value!;
```

## Additional information

I would like to keep this package minimal, but please get in touch on github if
you have suggestions to improvements.

The name was inspired by the `ErrorOr` type of [SerenityOS](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h).

The Succes/Failure type pattern was inspired by [result_type](https://pub.dev/packages/result_type).