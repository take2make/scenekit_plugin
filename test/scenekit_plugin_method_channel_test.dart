import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scenekit_plugin/scenekit_plugin_method_channel.dart';

void main() {
  MethodChannelScenekitPlugin platform = MethodChannelScenekitPlugin();
  const MethodChannel channel = MethodChannel('scenekit_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
