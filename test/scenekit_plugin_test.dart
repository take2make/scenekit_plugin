import 'package:flutter_test/flutter_test.dart';
import 'package:scenekit_plugin/scenekit_plugin.dart';
import 'package:scenekit_plugin/scenekit_plugin_platform_interface.dart';
import 'package:scenekit_plugin/scenekit_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScenekitPluginPlatform
    with MockPlatformInterfaceMixin
    implements ScenekitPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScenekitPluginPlatform initialPlatform = ScenekitPluginPlatform.instance;

  test('$MethodChannelScenekitPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScenekitPlugin>());
  });

  test('getPlatformVersion', () async {
    ScenekitPlugin scenekitPlugin = ScenekitPlugin();
    MockScenekitPluginPlatform fakePlatform = MockScenekitPluginPlatform();
    ScenekitPluginPlatform.instance = fakePlatform;

    expect(await scenekitPlugin.getPlatformVersion(), '42');
  });
}
