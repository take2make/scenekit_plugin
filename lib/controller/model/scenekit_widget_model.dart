import 'package:flutter/material.dart';

class ScenekitWidgetModel {
  final double lat;
  final double long;
  final String? assetName;
  final int? hexColor;
  final VoidCallback? onWidgetTap;
  String? name;

  set setWidgetName(String widgetName) => name = widgetName;

  ScenekitWidgetModel({
    required this.lat,
    required this.long,
    this.name,
    this.assetName,
    this.hexColor,
    this.onWidgetTap,
  });
}
