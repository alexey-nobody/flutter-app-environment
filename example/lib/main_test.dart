import 'package:example/app.dart';
import 'package:example/models/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_environment/flutter_app_environment.dart';

Future<void> main() async {
  // Initializing the environment from the entrypoint file.
  Environment.init<EnvironmentConfig>(
    environmentType: EnvironmentType.test,
    config: const EnvironmentConfig(
      title: 'Test evironment title',
      initialCounter: 0,
    ),
  );

  runApp(const App());
}
