# ErrorOr

A simple class `ErrorOr` for returning a result with either a value `T` or an
error `Object`.

## Features

I found it useful for always returning a value from an async function, so i
could `await` it, without having to `try catch` it - which i would rather do in
the called function.

`ErrorOr` can also be used for non-async (normal sync) functions.

There are other "result" type packages, but i wanted something simple, which
would either be the expected value, or an `Object` which usually is some type of
`Exception` from a `try catch` error.

Also it is similar named to the [SerenityOS](https://github.com/SerenityOS/serenity/blob/master/AK/Error.h)
`ErrorOr` type.

## Getting started

Make your function return an `ErrorOr` or a `Future<ErrorOr<SomeType>>`, which
you would `await` in the calling class.

You need to check if the result `hasError` and handle that, (e.g. checking for
expected exception types and showing a UI), before getting the `value`. The 
value is an optional so you need to force it with `!`.

## Usage

Here is an example where 

```dart
Future<ErrorOr<LocationPermission>> requestLocationPermission() async {
  LocationPermission permission;
  try {
	  permission = await Geolocator.checkPermission();
  } catch (e) {
	  return ErrorOr.error(e);
  }
  switch (permission) {
	  // users will have to change this manually in settings (or is on web)
	  case LocationPermission.deniedForever:
	  case LocationPermission.unableToDetermine:
	  // we have location permission, request immediately
	  case LocationPermission.whileInUse:
	  case LocationPermission.always:
	      return ErrorOr.value(permission);
	  case LocationPermission.denied:
	  // initial state, request permission
	  try {
		  permission = await Geolocator.requestPermission();
	  } catch (e) {
		  return ErrorOr.error(e);
	  }
	  return ErrorOr.value(permission);
  }
}
```

## Additional information

I would like to keep this package minimal, but please get in touch on github if
you have suggestions to improvements.
