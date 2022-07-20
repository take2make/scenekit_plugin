import 'dart:convert';
import "dart:typed_data";
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:scenekit_plugin/controller/model/scenekit_widget_model.dart';

class ScenekitController {
  ScenekitController.init({required this.id}) {
    _channel = MethodChannel('scenekit_$id');
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "widget_tap":
          {
            final key = call.arguments;
            _callTapCallback(key);
            break;
          }
      }
      return;
    });
    _channel.invokeMethod<void>('init', {
      "showStatistics": false,
    });
  }

  late MethodChannel _channel;
  final int id;
  late List<ScenekitWidgetModel> widgetModels;

  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('checkConfiguration');
    return version;
  }

  Future<void> dispose() async {
    await _channel.invokeMethod("dispose");
  }

  Future<void> removeWidgets() async {
    await _channel.invokeMethod("remove_widgets");
  }

  Future<void> addEarthToScene({
    double? initialScale,
    int? backgroundColor,
    double? x,
    double? y,
    double? z,
  }) async {
    await _channel.invokeMethod("add_earth_to_scene", {
      "initialScale": initialScale,
      if (backgroundColor != null) "backgroundColor": backgroundColor.toInt(),
      "x": x ?? 0,
      "y": y ?? 0,
      "z": z ?? 0,
    });
  }

  Future<void> setWidgetsToEarth(
      {required List<ScenekitWidgetModel> models}) async {
    widgetModels = models;
    List<Map<String, Object?>> widgetsListMap = [];
    for (int i = 0; i < models.length; i++) {
      widgetsListMap.add({
        "key": models[i].key,
        "latitude": models[i].lat,
        "longitude": models[i].long,
        "color": models[i].color,
        "imageData": models[i].assetName != null
            ? await convertImageToBase64(assetName: models[i].assetName!)
            : "",
      });
    }
    await _channel.invokeMethod("add_widgets_to_earth", {
      "widgets": widgetsListMap,
    });
  }

  Future<String> convertImageToBase64({required String assetName}) async {
    ByteData bytes = await rootBundle.load(assetName);
    var buffer = bytes.buffer;
    var encodedString = base64.encode(Uint8List.view(buffer));
    return encodedString;
  }

  void _callTapCallback(String key) {
    final widgetModel = widgetModels.firstWhereOrNull(
      (element) => element.key == key,
    );
    widgetModel?.onWidgetTap?.call();
  }
}
