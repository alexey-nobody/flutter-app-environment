import 'package:example/app.dart';
import 'package:example/models/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_environment/flutter_app_environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing the environment from the file.
  await Environment.init<EnvironmentConfig, EnvironmentType>(
    environmentType: EnvironmentType.development,
    parser: EnvironmentConfig.fromJson,
  );

  runApp(const App());
}
