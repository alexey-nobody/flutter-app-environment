# Flutter App Environment
A simple solution to manage environment variables using `.json` or `.env` files.

---

## Links

- See [CHANGELOG.md](./CHANGELOG.md) for major/breaking updates.
- Check out the [Example](./example/) for a detailed explanation of all features.

---

## Installation

To install the package, run the following command:

```sh
flutter pub add flutter_app_environment
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

- For **EnvironmentType.development**, use `development.json` or `development.env` as the configuration file.
- For **EnvironmentType.test**, use `test.json` or `test.env` as the configuration file.
- For **EnvironmentType.production**, use `production.json` or `production.env` as the configuration file.

### Usage with `.json`: Three Simple Steps

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

    await Environment.init<EnvironmentConfig, EnvironmentType>(
      environmentType: EnvironmentType.development,
      parser: EnvironmentConfig.fromJson,
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

2. **Initialize the Environment**

    ```dart
    await Environment.init<EnvironmentConfig, CustomEnvironmentType>(
      environmentType: CustomEnvironmentType.stage,
      parser: EnvironmentConfig.fromJson,
    );
    ```

---

## Managing Environment Variables from a `.env` File

Initialize the environment by specifying `EnvironmentSourceType.env`:

```dart
await Environment.init<EnvironmentConfig, EnvironmentType>(
  environmentType: EnvironmentType.development,
  source: EnvironmentSourceType.env,
  parser: EnvironmentConfig.fromJson,
);
```

### `.env` File Format

The parser supports:
- Basic key-value pairs.
- Comments (lines starting with `#`).
- Trailing comments.
- Quoted values (single and double quotes).
- Automatic type inference for `int`, `double`, and `bool`.

```env
TITLE=Environment Development
INITIAL_COUNTER=10
IS_DEBUG=true
# This is a comment
API_KEY="your_secret_key"
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
│       ├── production.json
│       └── development.env
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
- The `EnvironmentConfig` class should match the structure of your `.json` or `.env` files.
- You can switch between different environment types depending on your build (development, test, production) or create custom environment types.

---

## Contribute

Feel free to fork, improve, submit pull requests, or report issues. I’ll be happy to fix bugs or enhance the extension based on your feedback.

---

### License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.
