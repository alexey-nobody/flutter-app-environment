import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_app_environment/flutter_app_environment.dart';
import 'package:flutter_test/flutter_test.dart';

// Simple config model for testing
class TestConfig {
  const TestConfig({required this.name, required this.value});
  final String name;
  final int value;

  factory TestConfig.fromJson(Map<String, dynamic> json) => TestConfig(
        name: json['name'] as String,
        value: json['value'] as int,
      );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Environment', () {
    setUp(() {
      Environment.reset();
      // Evict potential cached assets
      rootBundle
        ..evict('res/config/development.json')
        ..evict('res/config/development.env')
        ..evict('res/config/production.json')
        ..evict('res/config/test.json');
    });

    test(
      'instance() should throw EnvironmentNotInitializedException if not initialized',
      () {
        expect(
          Environment<TestConfig>.instance,
          throwsA(isA<EnvironmentNotInitializedException>()),
        );
      },
    );

    test('init should load JSON config and initialize singleton', () async {
      // Mocking asset loading
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final encoded = utf8.encode(jsonEncode({'name': 'dev', 'value': 1}));
          return encoded.buffer.asByteData();
        },
      );

      await Environment.init<TestConfig, EnvironmentType>(
        environmentType: EnvironmentType.development,
        parser: TestConfig.fromJson,
      );

      final instance = Environment<TestConfig>.instance();
      expect(instance.config.name, 'dev');
      expect(instance.config.value, 1);
      expect(instance.currentEnvironmentType, EnvironmentType.development);
      expect(instance.isDebug, true);
    });

    test('init should load .env config and initialize singleton', () async {
      // Mocking asset loading for .env
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final encoded = utf8.encode('name=env_dev\nvalue=2');
          return encoded.buffer.asByteData();
        },
      );

      await Environment.init<TestConfig, EnvironmentType>(
        environmentType: EnvironmentType.development,
        source: EnvironmentSourceType.env,
        parser: TestConfig.fromJson,
      );

      final instance = Environment<TestConfig>.instance();
      expect(instance.config.name, 'env_dev');
      expect(instance.config.value, 2);
      expect(instance.currentEnvironmentType, EnvironmentType.development);
    });

    test(
        'should throw EnvironmentAlreadyInitializedException if initialized twice',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final encoded = utf8.encode(jsonEncode({'name': 'dev', 'value': 1}));
          return encoded.buffer.asByteData();
        },
      );

      await Environment.init<TestConfig, EnvironmentType>(
        environmentType: EnvironmentType.development,
        parser: TestConfig.fromJson,
      );

      expect(
        Environment.init<TestConfig, EnvironmentType>(
          environmentType: EnvironmentType.development,
          parser: TestConfig.fromJson,
        ),
        throwsA(isA<EnvironmentAlreadyInitializedException>()),
      );
    });

    test('should throw EnvironmentFailedToLoadException if file is missing',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async => null,
      );

      expect(
        Environment.init<TestConfig, EnvironmentType>(
          environmentType: EnvironmentType.development,
          parser: TestConfig.fromJson,
        ),
        throwsA(isA<EnvironmentFailedToLoadException>()),
      );
    });

    test('isDebug should return correct value based on EnvironmentType',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final encoded =
              utf8.encode(jsonEncode({'name': 'prod', 'value': 100}));
          return encoded.buffer.asByteData();
        },
      );

      await Environment.init<TestConfig, EnvironmentType>(
        environmentType: EnvironmentType.production,
        parser: TestConfig.fromJson,
      );

      expect(Environment<TestConfig>.instance().isDebug, false);
    });

    test('should initialize with custom debug options', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        final encoded = utf8.encode(jsonEncode({'name': 'dev', 'value': 1}));
        return encoded.buffer.asByteData();
      });

      const debugOptions = DebugOptions(
        debugShowCheckedModeBanner: true,
        showPerformanceOverlay: true,
      );

      await Environment.init<TestConfig, EnvironmentType>(
        environmentType: EnvironmentType.development,
        parser: TestConfig.fromJson,
        debugOptions: debugOptions,
      );

      final instance = Environment<TestConfig>.instance();
      expect(instance.debugOptions.debugShowCheckedModeBanner, true);
      expect(instance.debugOptions.showPerformanceOverlay, true);
      expect(instance.debugOptions.debugShowMaterialGrid, false);
    });
  });
}
