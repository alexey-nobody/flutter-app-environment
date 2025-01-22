/// Exception that is thrown when the environment is not initialized.
class EnvironmentNotInitializedException implements Exception {
  const EnvironmentNotInitializedException();

  @override
  String toString() {
    return 'EnvironmentNotInitializedException';
  }
}
