/// Enum with three values standard of environment types: development, test, and production.
enum EnvironmentType { development, test, production }

/// An extension method that takes the [EnvironmentType] enum, convert it to [String] and returns the last part of the enum.
extension EnvironmentTypeToShortString on EnvironmentType {
  String toShortString() {
    return toString().split('.').last;
  }
}
