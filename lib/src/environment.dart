import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_environment/src/models/debug_options.dart';
import 'package:flutter_app_environment/src/models/environment_type.dart';

class Environment<T> {
  const Environment._({
    required T config,
    required EnvironmentType environmentType,
    DebugOptions debugOptions = const DebugOptions(),
  })  : _config = config,
        _currentEnvironmentType = environmentType,
        _debugOptions = debugOptions;

  factory Environment.instance() {
    if (_instance == null) {
      throw Exception('Need call init method first!');
    }
    return _instance as Environment<T>;
  }

  static Environment? _instance;

  final EnvironmentType _currentEnvironmentType;
  final T _config;
  final DebugOptions _debugOptions;

  /// A getter that returns the current environment type.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  EnvironmentType get currentEnvironmentType {
    if (_instance == null) {
      throw Exception('Need call init method first!');
    }

    return _currentEnvironmentType;
  }

  /// A getter that returns the current environment config.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  T get config {
    if (_instance == null) {
      throw Exception('Need call init method first!');
    }

    return _config;
  }

  /// A getter that returns the current debug options.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  DebugOptions get debugOptions {
    if (_instance == null) {
      throw Exception('Need call init method first!');
    }

    return _debugOptions;
  }

  /// A getter that returns a boolean value. When current environment is development a getter returned true.
  ///
  /// Throws an [Exception] when Environment.init not called before and Environment not initialized.
  bool get isDebug {
    if (_instance == null) {
      throw Exception('Need call init method first!');
    }

    return _currentEnvironmentType == EnvironmentType.development;
  }

  /// Initialize the environment from configuration model and store it in entrypoint file.
  ///
  /// Params:
  ///   [environmentType] The environment type that you want to initialize the environment with.
  ///   [config] Environment variables
  ///   [debugOptions] An optional parameter that allows you to specify the debug options for the environment.
  ///
  /// Throws an [Exception] when [Environment] already initialized.
  static Future<void> init<T>({
    required EnvironmentType environmentType,
    required T config,
    DebugOptions debugOptions = const DebugOptions(),
  }) async {
    if (_instance == null) {
      _instance = Environment<T>._(
        environmentType: environmentType,
        debugOptions: debugOptions,
        config: config,
      );
    } else {
      throw Exception('Environment already initialized');
    }
  }

  /// Initialize the environment from file with JSON type in the assets folder.
  ///
  /// Params:
  ///   [environmentType] The environment type that you want to initialize the environment with.
  ///   [fromJson] A function that takes a Map<String, dynamic> from environment file and returns an instance of the config class.
  ///   [debugOptions] An optional parameter that allows you to specify the debug options for the environment.
  ///
  /// Throws an [Exception] when [Environment] already initialized.
  static Future<void> initFromJson<T>({
    required EnvironmentType environmentType,
    required T Function(Map<String, dynamic> data) fromJson,
    DebugOptions debugOptions = const DebugOptions(),
  }) async {
    if (_instance == null) {
      final environmentFileName = '${environmentType.toShortString()}.json';
      final environmentPath = 'res/config/$environmentFileName';

      final content = await rootBundle.loadString(environmentPath);
      final jsonObject = jsonDecode(content) as Map<String, dynamic>;

      _instance = Environment<T>._(
        environmentType: environmentType,
        debugOptions: debugOptions,
        config: fromJson(jsonObject),
      );
    } else {
      throw Exception('Environment already initialized');
    }
  }
}
