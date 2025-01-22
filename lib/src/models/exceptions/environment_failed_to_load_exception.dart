/// Exception that is thrown when the environment file failed to load.
class EnvironmentFailedToLoadException implements Exception {
  const EnvironmentFailedToLoadException(this.message);

  /// The message of the exception.
  final String message;

  @override
  String toString() {
    return 'EnvironmentFailedToLoadException: $message';
  }
}
