import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:scenekit_plugin/controller/view/scenekit_controller.dart';

typedef ScenekitPluginCreatedCallback = void Function(
  ScenekitController controller,
);

class ScenekitView extends StatefulWidget {
  final Function(String)? onNodeTap;
  const ScenekitView({
    Key? key,
    this.onNodeTap,
    required this.onScenekitViewCreated,
  }) : super(key: key);

  final ScenekitPluginCreatedCallback onScenekitViewCreated;

  @override
  State<ScenekitView> createState() => _ScenekitViewState();
}

class _ScenekitViewState extends State<ScenekitView> {
  late ScenekitController scenekitController;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        onTapDown: (details) async {
          final nodeName = await scenekitController.handleTap(
            x: details.localPosition.dx,
            y: details.localPosition.dy,
          );
          if (nodeName != null && widget.onNodeTap != null) {
            widget.onNodeTap!(nodeName);
          }
        },
        child: UiKitView(
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          viewType: 'scenekit',
          onPlatformViewCreated: onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    }

    return Text('$defaultTargetPlatform is not supported by this plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    scenekitController = ScenekitController.init(id: id);
    widget.onScenekitViewCreated(scenekitController);
  }
}
