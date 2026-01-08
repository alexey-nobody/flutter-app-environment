import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_environment/src/environment_env_file_parser.dart';
import 'package:flutter_app_environment/src/models/debug_options.dart';
import 'package:flutter_app_environment/src/models/environment_source_type.dart';
import 'package:flutter_app_environment/src/models/environment_type.dart';
import 'package:flutter_app_environment/src/models/exceptions/environment_already_initialized_exception.dart';
import 'package:flutter_app_environment/src/models/exceptions/environment_failed_to_load_exception.dart';
import 'package:flutter_app_environment/src/models/exceptions/environment_not_initialized_exception.dart';

class Environment<T> {
  const Environment._({
    required T config,
    required Enum environmentType,
    DebugOptions debugOptions = const DebugOptions(),
  })  : _config = config,
        _currentEnvironmentType = environmentType,
        _debugOptions = debugOptions;

  factory Environment.instance() {
    if (_instance == null) {
      throw const EnvironmentNotInitializedException();
    }

    return _instance! as Environment<T>;
  }

  static Environment? _instance;

  final Enum _currentEnvironmentType;
  final T _config;
  final DebugOptions _debugOptions;

  /// A getter that returns the current environment type.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  Enum get currentEnvironmentType {
    if (_instance == null) {
      throw const EnvironmentNotInitializedException();
    }

    return _currentEnvironmentType;
  }

  /// A getter that returns the current environment config.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  T get config {
    if (_instance == null) {
      throw const EnvironmentNotInitializedException();
    }

    return _config;
  }

  /// A getter that returns the current debug options.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  DebugOptions get debugOptions {
    if (_instance == null) {
      throw const EnvironmentNotInitializedException();
    }

    return _debugOptions;
  }

  /// A getter that returns a boolean value. When current environment is development a getter returned true.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  bool get isDebug {
    if (_instance == null) {
      throw const EnvironmentNotInitializedException();
    }

    return _currentEnvironmentType == EnvironmentType.development;
  }

  /// Initialize the environment from a file in the assets folder.
  ///
  /// Params:
  ///   [environmentType] The environment type (standard [EnvironmentType] or a custom Enum).
  ///   [parser] A function to parse the Map into your configuration model [T].
  ///   [source] The type of source file ([EnvironmentSourceType.json] by default).
  ///   [debugOptions] Optional debug settings for the environment.
  ///
  /// Throws an [EnvironmentAlreadyInitializedException] if initialized more than once.
  /// Throws an [EnvironmentFailedToLoadException] if the file is missing or invalid.
  static Future<void> init<T, E extends Enum>({
    required E environmentType,
    required T Function(Map<String, dynamic> data) parser,
    EnvironmentSourceType source = EnvironmentSourceType.json,
    DebugOptions debugOptions = const DebugOptions(),
  }) async {
    if (_instance == null) {
      final environmentFileName =
          '${environmentType.name}.${source == EnvironmentSourceType.json ? 'json' : 'env'}';
      final environmentPath = 'res/config/$environmentFileName';

      try {
        final content = await rootBundle.loadString(environmentPath);
        final Map<String, dynamic> contentMap;

        if (source == EnvironmentSourceType.json) {
          contentMap = jsonDecode(content) as Map<String, dynamic>;
        } else {
          contentMap = EnvironmentEnvFileParser.parse(content);
        }

        _instance = Environment<T>._(
          environmentType: environmentType,
          debugOptions: debugOptions,
          config: parser(contentMap),
        );
        // ignore: avoid_catching_errors
      } on Error {
        throw EnvironmentFailedToLoadException(
          'Failed to load environment file: $environmentPath',
        );
      }
    } else {
      throw EnvironmentAlreadyInitializedException(
        'Environment already initialized with ${_instance!.currentEnvironmentType} environment type',
      );
    }
  }

  /// Resets the environment instance.
  ///
  /// This should only be used for testing purposes.
  static void reset() {
    _instance = null;
  }
}
