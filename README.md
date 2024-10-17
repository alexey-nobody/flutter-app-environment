# Flutter App Environment
A simple solution to manage environment variables using `.json` files or configuration in the entrypoint file.

---

## Links

- See [CHANGELOG.md](./CHANGELOG.md) for major/breaking updates.
- Check out the [Example](./example/) for a detailed explanation of all features.

---

## Installation

To install the package, run the following command:

```sh
flutter pub add --dev flutter_app_environment
```

---

## Managing Environment Variables from a `.json` File

### Requirements

Before initializing the environment, ensure the following:

```dart
WidgetsFlutterBinding.ensureInitialized();
```

Add the configuration files path to **pubspec.yaml**:

```yaml
flutter:
  assets:
    - res/config/
```

- For **EnvironmentType.development**, use `development.json` as the configuration file.
- For **EnvironmentType.test**, use `test.json` as the configuration file.
- For **EnvironmentType.production**, use `production.json` as the configuration file.

### Usage: Three Simple Steps

1. **Create the Config**

    ```dart
    @JsonSerializable(createToJson: false)
    class EnvironmentConfig {
      const EnvironmentConfig({
        required this.title,
        required this.initialCounter,
      });

      factory EnvironmentConfig.fromJson(Map<String, dynamic> json) =>
          _$EnvironmentConfigFromJson(json);

      final String title;
      final int initialCounter;
    }
    ```

2. **Initialize the Environment**

    ```dart
    WidgetsFlutterBinding.ensureInitialized();

    await Environment.initFromJson<EnvironmentConfig>(
      environmentType: EnvironmentType.development,
      fromJson: EnvironmentConfig.fromJson,
    );
    ```

3. **Use the Config**

    ```dart
    home: HomePage(
      title: Environment<EnvironmentConfig>.instance().config.title,
    ),
    ```

---

## Managing Environment Variables from the Entrypoint File

### Usage: Three Simple Steps

1. **Create the Config**
    (same as the previous example)

2. **Initialize the Environment**

    ```dart
    WidgetsFlutterBinding.ensureInitialized();

    Environment.init<EnvironmentConfig>(
      environmentType: EnvironmentType.test,
      config: const EnvironmentConfig(
        title: 'Test environment title',
        initialCounter: 0,
      ),
    );
    ```

3. **Use the Config**

    ```dart
    home: HomePage(
      title: Environment<EnvironmentConfig>.instance().config.title,
    ),
    ```

---

## Managing Environment Variables with Custom Types

1. **Create a Custom Environment Type**

    ```dart
    enum CustomEnvironmentType { dev, stage, prod }
    ```

2. **Initialize with a JSON Config**

    ```dart
    await Environment.initFromJsonWithCustomType<EnvironmentConfig, CustomEnvironmentType>(
      environmentType: CustomEnvironmentType.stage,
      fromJson: EnvironmentConfig.fromJson,
    );
    ```

3. **Initialize from the Entrypoint File**

    ```dart
    Environment.initWithCustomType<EnvironmentConfig, CustomEnvironmentType>(
      environmentType: CustomEnvironmentType.dev,
      config: const EnvironmentConfig(
        title: 'Custom environment title',
        initialCounter: 0,
      ),
    );
    ```

---

### Example Project Structure

For a better understanding, here's an example of how your project structure might look when handling environment variables:

```
your_project/
│
├── res/
│   └── config/
│       ├── development.json
│       ├── test.json
│       └── production.json
│
├── lib/
│   ├── main.dart
│   └── environment_config.dart
│
└── pubspec.yaml
```

In this example, JSON configuration files are stored in the `res/config/` folder and declared in `pubspec.yaml`. The environment configuration is loaded in `main.dart` and used throughout the app.

---

### Notes

- Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before initializing the environment.
- The `EnvironmentConfig` class should match the structure of your `.json` files or entrypoint configurations.
- You can switch between different environment types depending on your build (development, test, production) or create custom environment types.

---

## Contribute

Feel free to fork, improve, submit pull requests, or report issues. I’ll be happy to fix bugs or enhance the extension based on your feedback.

---

### License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.
