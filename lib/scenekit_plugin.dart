import 'scenekit_plugin_platform_interface.dart';

class ScenekitPlugin {
  Future<String?> getPlatformVersion() {
    return ScenekitPluginPlatform.instance.getPlatformVersion();
  }
}
