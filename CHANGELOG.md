## 2.0.0
 - **Breaking Change**: Unified environment initialization into a single `Environment.init` method. This method is now generic and replaces all previous initialization methods (`init`, `initFromJson`, etc.).
 - **Breaking Change**: Removed `toShortString()` extension method in favor of native `.name` property.
 - **Improvement**: Added support for `.env` files for environment initialization.
 - **Improvement**: Added `EnvironmentSourceType` to specify the source file format (`json` or `env`).
 - **Improvement**: Renamed `fromJson` parameter to `parser` in `Environment.init` to support different source formats.
 - **Improvement**: Added basic type inference for `.env` values (int, double, bool).
 - Added comprehensive unit tests for `.env` parsing and `Environment` singleton.
 - Exported environment exceptions for better error handling by users.
 - Renamed internal variable `configMap` to `contentMap` and added `Environment.reset()` for testing.
 - **Improvement**: Added proper error handling to the initialization process. Now throws `EnvironmentFailedToLoadException` on failure.

## 1.0.4
 - added new exceptions to improve error handling:
   - EnvironmentFailedToLoadException
   - EnvironmentAlreadyInitializedException
   - EnvironmentNotInitializedException
 - improved error handling during environment initialization

## 1.0.3
 - refactor documentation and update linting rules for improved code consistency

## 1.0.2
 - update docs
 - add method initWithCustomType - for use custom environment type from entrypoint
 - add method initFromJsonWithCustomType - for use custom environment type from json

## 1.0.1
 - environment variables initialization refactor

## 1.0.0
 - initial release