import 'package:json_annotation/json_annotation.dart';

part 'environment_config.g.dart';

/// Example the environment variables model that has two properties: [title] and [initialCounter]
///
/// Used JsonSerializable as deserializer for json configurations files. Also works with Freezed.
///
/// See:
/// * [json_serializable](https://pub.dev/packages/json_serializable)
/// * [freezed](https://pub.dev/packages/freezed)
@JsonSerializable(createToJson: false)
class EnvironmentConfig {
  const EnvironmentConfig({
    required this.title,
    required this.initialCounter,
  });

  // this factory constructor need only when you use JSON file for handle environment variables
  factory EnvironmentConfig.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentConfigFromJson(json);

  final String title;

  final int initialCounter;
}
