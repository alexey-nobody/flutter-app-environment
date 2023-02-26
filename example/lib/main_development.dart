import 'package:example/app.dart';
import 'package:example/models/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_environment/environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing the environment from the json file.
  // Configuration for environment stored in res/config/development.json
  await Environment.initFromJson<EnvironmentConfig>(
    environmentType: EnvironmentType.development,
    fromJson: EnvironmentConfig.fromJson,
  );

  runApp(const App());
}
