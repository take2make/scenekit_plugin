import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'scenekit_plugin_method_channel.dart';

abstract class ScenekitPluginPlatform extends PlatformInterface {
  /// Constructs a ScenekitPluginPlatform.
  ScenekitPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScenekitPluginPlatform _instance = MethodChannelScenekitPlugin();

  /// The default instance of [ScenekitPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelScenekitPlugin].
  static ScenekitPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScenekitPluginPlatform] when
  /// they register themselves.
  static set instance(ScenekitPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
