# ErrorOr

Return a result `ErrorOr` with either a value `T` or an error `Object`.

## Features

Alternative error handling by wrapping a function that might throw an error,
into a function that returns `ErrorOr`.

Call the function that returns an `ErrorOr` without the try/catch and check if
it `hasError` before calling `value`.

Alternatively, pass the throwing function to `trySync` or `tryAsync`; it will
handle the try/catch and return an `ErrorOr` with the result.

`ErrorOr` can be used for both async and synchronous functions.

## API

Create a `ErrorOr` instance by calling one of its factory constructors `value`
or `error`.

Check `hasError` or `hasValue`, before calling `error` or `value`. If either is
called without the proper check, a `ErrorOrTypeError` is thrown.

The convenient functions `trySync` and `tryAsync`, does the try/catch for you
given a throwing function.

## Examples

Async example which returns a `Future` with an `ErrorOr`

```dart
Future<ErrorOr<T>> asyncFuncWhichThrowsWrapper() async {
  try {
    return ErrorOr.value(await asyncFuncWhichThrows());
  } catch (e) {
    return ErrorOr.error(e);
  }
}

ErrorOr<String> valueOrError = await asyncFuncWhichThrowsWrapper();
if (valueOrError.hasError) {
  return valueOrError;
}
String value = valueOrError.value;
```

Or simplify this by wrapping `syncFuncWhichMayThrow` using `tryAsync`.

```dart
ErrorOr<String> valueOrError = await ErrorOr.tryAsync(asyncFuncWhichThrows)
if (valueOrError.hasError) {
  return valueOrError;
}
String value = valueOrError.value;
```

This is the same for synchronous functions, just remove the Future/await and use
`trySync` to wrap the throwing function.

## Additional information

The "ErrorOr" is inspired by the SerenityOS [ErrorOr](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h) type.

The Success/Failure pattern was inspired by [result_type](https://pub.dev/packages/result_type).

I'd like to keep this package minimal, but please get in touch on github if you
have suggestions to improvements.
