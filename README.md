# ErrorOr

Return a result `ErrorOr` with either a value `T` or an error `Object`.

## Features

Write async code like you'd write synchronous, whilst still dealing with errors.

Always return a value `ErrorOr` from an async function. Let the called function
handle the error and return an `ErrorOr`. The caller can then `await` the result
without a `try catch`.

A subclass of `ErrorOr` contains either the expected value `T` or an error
`Object` (usually an `Exception` returned from a `try catch`).

Internally, we create a private subclass of `ErrorOr`, either a `_ValueWrapper`
or an `_ErrorWrapper`, with the expected non-null value.

`ErrorOr` can be used for both async and synchronous functions.

## Getting started

Make a function return a `Future<ErrorOr>`, which you'll `await` in the calling
function.

Create a `ErrorOr` instance by calling one of its factory constructors `value`
or `error`.

Check `hasError` or `hasValue`, before calling `error` or `value`. If either is
called without the proper check, a `ErrorOrTypeError` is thrown.

## Examples

Sync example with ErrorOr

```dart
ErrorOr<String> getSyncValue() {
  try {
    return ErrorOr.value(getSyncValueWhichMayThrow());
  } catch (e) {
    return ErrorOr.error(e);
  }
}
ErrorOr<String> valueOrError = getSyncValue();
if (valueOrError.hasError) {
  return valueOrError;
}
String value = valueOrError.value;
```

Async example with ErrorOr

```dart
Future<ErrorOr<String>> getAsyncValue() async {
  try {
    return ErrorOr.value(await getAsyncValueWhichMayThrow());
  } catch (e) {
    return ErrorOr.error(e);
  }
}
ErrorOr<String> valueOrError = await getAsyncValue();
if (valueOrError.hasError) {
  return valueOrError;
}
String value = valueOrError.value;
```

> Notice how similar the async example is to the synchronous.

## Additional information

I'd like to keep this package minimal, but please get in touch on github if you
have suggestions to improvements.

The name was inspired by the `ErrorOr` type of [SerenityOS](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h).

The Success/Failure pattern was inspired by [result_type](https://pub.dev/packages/result_type).