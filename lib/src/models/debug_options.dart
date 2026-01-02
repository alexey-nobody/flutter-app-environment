import 'package:flutter_app_environment/flutter_app_environment.dart';

/// Class with options to use in Flutter's `debug` mode.
///
/// You can use this class to specify which debug options you want to use in
/// Flutter's `debug` mode. You can use it when you're initializing the
/// environment with [Environment.init].
///
/// See also:
///
/// * [Environment.init]
class DebugOptions {
  const DebugOptions({
    this.showPerformanceOverlay = false,
    this.debugShowMaterialGrid = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
  });

  final bool showPerformanceOverlay;
  final bool debugShowMaterialGrid;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
}
