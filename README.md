# Flutter App Environment
Simple solution to handle environment variables using `.json` or config in entrypoint file.

---

## Links

- See [CHANGELOG.md](./CHANGELOG.md) for major/breaking updates
- [Example](./example/) with explain all features


## Installation

```sh
$ flutter pub add --dev flutter_app_environment
```


## Requirements for handle environment variables from .json config

- Call before initialize the environment
    ```dart   
    WidgetsFlutterBinding.ensureInitialized();
    ```

- Add ```res/config/``` to **pubspec.yaml** assets. This folder contains json files with environment variables
    ```yaml
    flutter:
        assets:
            - res/config/
    ```

- For **EnvironmentType.development** use name **development.json** for configuration file

- For **EnvironmentType.test** use name **test.json** for configuration file

- For **EnvironmentType.production** use name **production.json**  for configuration file

## Usage for handle environment variables from .json config

### Easy **three** steps

1. **Create config**
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

2. **Initialize**
    ```dart
    WidgetsFlutterBinding.ensureInitialized();

    await Environment.initFromJson<EnvironmentConfig>(
        environmentType: EnvironmentType.development,
        fromJson: EnvironmentConfig.fromJson,
    );
    ```

3. **Use it**
    ```dart
    home: HomePage(
        title: Environment<EnvironmentConfig>.instance().config.title,
    ),
    ```


## Contribute

Please feel free to fork, improve, make pull requests or fill issues.
I'll be glad to fix bugs you encountered or improve the extension.