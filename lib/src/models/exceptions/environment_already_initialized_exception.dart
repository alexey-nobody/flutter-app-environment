/// Exception that is thrown when the environment is already initialized.
class EnvironmentAlreadyInitializedException implements Exception {
  const EnvironmentAlreadyInitializedException(this.message);

  /// The message of the exception.
  final String message;
}
