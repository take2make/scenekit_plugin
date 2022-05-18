import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:scenekit_plugin/controller/model/scenekit_widget_model.dart';

class ScenekitController {
  ScenekitController.init({
    required this.id,
  }) {
    _channel = MethodChannel('scenekit_$id');
    _channel.invokeMethod<void>('init', {
      "showStatistics": false,
    });
  }

  late MethodChannel _channel;
  final int id;
  late List<ScenekitWidgetModel> widgetModels;

  Future<void> dispose() async {
    await _channel.invokeMethod("dispose");
  }

  Future<void> addWidgetToScene() async {
    await _channel.invokeMethod("add_widget_to_scene");
  }

  Future<void> addWidgetToEarth({required ScenekitWidgetModel model}) async {
    await _channel.invokeMethod("add_widget_to_earth", {
      "latitude": model.lat,
      "longitude": model.long,
      "widgetName": model.name,
      "hexColor": model.hexColor,
      "imageData": model.assetName != null
          ? await convertImageToBase64(assetName: model.assetName!)
          : null,
    });
  }

  Future<void> addWidgetsToEarth(
      {required List<ScenekitWidgetModel> models}) async {
    widgetModels = models;
    List<Map<String, Object?>> widgetsListMap = [];
    for (final model in models) {
      widgetsListMap.add({
        "latitude": model.lat,
        "longitude": model.long,
        "widgetName": model.name,
        "hexColor": model.hexColor,
        "imageData": model.assetName != null
            ? await convertImageToBase64(assetName: model.assetName!)
            : "",
      });
    }
    await _channel.invokeMethod("add_widgets_to_earth", {
      "widgets": widgetsListMap,
    });
  }

  Future<String?> handleTap({
    required double x,
    required double y,
  }) async {
    final result = await _channel.invokeMethod("handle_tap", {
      "x": x,
      "y": y,
    });
    final widgetModel = widgetModels.firstWhere(
      (element) => element.name == result,
    );
    if (widgetModel.onWidgetTap != null) widgetModel.onWidgetTap!();
    return result;
  }

  Future<String> convertImageToBase64({required String assetName}) async {
    ByteData bytes = await rootBundle.load(assetName);
    var buffer = bytes.buffer;
    var encodedString = base64.encode(Uint8List.view(buffer));
    return encodedString;
  }
}
