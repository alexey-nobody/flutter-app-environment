import 'package:json_annotation/json_annotation.dart';

part 'environment_from_json_config.g.dart';

/// [EnvironmentFromJsonConfig] example class that has two properties: [title] and [initialCounter]
///
/// Used JsonSerializable as deserializer for json configurations files.
/// Also works with Freezed.
///
/// See:
/// * [json_serializable](https://pub.dev/packages/json_serializable)
/// * [freezed](https://pub.dev/packages/freezed)
@JsonSerializable(createToJson: false)
class EnvironmentFromJsonConfig {
  const EnvironmentFromJsonConfig({
    required this.title,
    required this.initialCounter,
  });

  factory EnvironmentFromJsonConfig.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJsonConfigFromJson(json);

  final String title;

  final int initialCounter;
}
