# ErrorOr

Return a result `ErrorOr` with either a value `T` or an error `Object`.

## Features

Alternative error handling by wrapping a function that may throw exceptions, in
a function that handle these and returns an `ErrorOr`.

A more explicit way of defining a function which may return an error and avoid 
having to try/catch these functions.

`ErrorOr` can be used for both async and synchronous functions.

## API

Create an `ErrorOr` instance by calling one of its factory constructors `value`
or `error`.

Check `hasError` or `hasValue`, before calling `error` or `value`. If either is
called without the proper check, an `ErrorOrTypeError` is thrown.

The convenient function `ErrorOr.wrap`, does the try/catch logic for you given
a throwing function.

## Examples

Async example

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

Simplify using `ErrorOr.wrap`.

```dart
ErrorOr<String> valueOrError = await ErrorOr.wrap(asyncFuncWhichThrows)
if (valueOrError.hasError) {
  return valueOrError;
}
String value = valueOrError.value;
```

This is similar for synchronous functions, just remove the Future/await.

## Additional information

The "ErrorOr" is inspired by the SerenityOS [ErrorOr](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h) type.

The Success/Failure pattern was inspired by [result_type](https://pub.dev/packages/result_type).

I'd like to keep this package minimal, but please get in touch on github if you
have suggestions to improvements.
