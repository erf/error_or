# ErrorOr

A simple class `ErrorOr` for returning a result with either a value `T` or an
error `Object`.

## Features

I found it useful for always returning a value from an async function, so i
could `await` it, without having to `try catch` it - which i would rather do in
the called function.

`ErrorOr` can also be used for sync functions.

There are other "result" type packages, but i wanted something simple, which
would either be the expected value, or an `Object` which usually is some type of
`Exception` from a `try catch` error.

It is similar named to the [SerenityOS](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h) `ErrorOr` type.

## Getting started

Make a function return an `ErrorOr` or a `Future<ErrorOr<T>>`, which you'll
`await` in the calling class.

Then check if the result `hasError` and handle that, (e.g. checking for expected exception types and showing a UI), before getting the `value`. The value is an
optional so you need to force it with `!`.

## Usage

Example

```dart
Future<ErrorOr<LocationPermission>> checkPermission() async {
  try {
    return ErrorOr.value(await Geolocator.checkPermission());
  } catch (e) {
    return ErrorOr.error(e);
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
