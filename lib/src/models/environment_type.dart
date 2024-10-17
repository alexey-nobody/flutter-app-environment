/// Enum with three values standard of environment types: development, test, and production.
enum EnvironmentType { development, test, production }

/// An extension method that takes the [EnvironmentType] enum, convert it to [String] and returns the last part of the enum.
extension EnvironmentTypeToShortString on Enum {
  /// Takes the [EnvironmentType] enum, convert it to [String] and returns the last part of the enum.
  ///
  /// For example, [EnvironmentType.development] will return 'development'.
  ///
  /// Throws an [ArgumentError] if the [EnvironmentType] is null.
  String toShortString() {
    return toString().split('.').last;
  }
}
