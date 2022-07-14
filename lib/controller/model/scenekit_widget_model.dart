import 'package:flutter/material.dart';

class ScenekitWidgetModel {
  final String key;
  final double lat;
  final double long;
  final String? assetName;
  final int? color;
  final VoidCallback? onWidgetTap;

  ScenekitWidgetModel({
    required this.key,
    required this.lat,
    required this.long,
    this.assetName,
    this.color,
    this.onWidgetTap,
  });
}
