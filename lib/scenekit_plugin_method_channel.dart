import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'scenekit_plugin_platform_interface.dart';

/// An implementation of [ScenekitPluginPlatform] that uses method channels.
class MethodChannelScenekitPlugin extends ScenekitPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('scenekit_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('checkConfiguration');
    return version;
  }
}
