import 'package:example/models/environment_from_json_config.dart';
import 'package:example/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_environment/environment.dart';

class App extends StatelessWidget {
  const App({super.key});

  DebugOptions get _debugOptions =>
      Environment<EnvironmentFromJsonConfig>.instance().debugOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Environment<EnvironmentFromJsonConfig>.instance().config.title,
      showPerformanceOverlay: _debugOptions.showPerformanceOverlay,
      debugShowMaterialGrid: _debugOptions.debugShowMaterialGrid,
      checkerboardRasterCacheImages:
          _debugOptions.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debugOptions.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debugOptions.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debugOptions.debugShowCheckedModeBanner,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: Environment<EnvironmentFromJsonConfig>.instance().config.title,
      ),
    );
  }
}
