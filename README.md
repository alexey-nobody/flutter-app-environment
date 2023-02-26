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

## Requirements

- Call before initialize the environment
    ```dart   
    WidgetsFlutterBinding.ensureInitialized();
    ```


## Requirements for handle environment variables from .json config

- Add ```res/config/``` to **pubspec.yaml** assets. This folder contains json files with environment variables
    ```yaml
    flutter:
        assets:
            - res/config/
    ```

- For **EnvironmentType.development** use name **development.json** for configuration file

- For **EnvironmentType.test** use name **test.json** for configuration file

- For **EnvironmentType.production** use name **production.json**  for configuration file


## Contribute

Please feel free to fork, improve, make pull requests or fill issues.
I'll be glad to fix bugs you encountered or improve the extension.