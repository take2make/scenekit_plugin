import 'package:flutter/material.dart';

class ScenekitWidgetModel {
  final double lat;
  final double long;
  final String name;
  final String? assetName;
  final int? hexColor;
  final VoidCallback? onWidgetTap;

  ScenekitWidgetModel({
    required this.lat,
    required this.long,
    required this.name,
    this.assetName,
    this.hexColor,
    this.onWidgetTap,
  });
}
