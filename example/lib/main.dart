import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scenekit_plugin/controller/scenekit_plugin_controller_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ScenekitPage());
  }
}

class ScenekitPage extends StatefulWidget {
  const ScenekitPage({super.key});

  @override
  State<ScenekitPage> createState() => _ScenekitPageState();
}

class _ScenekitPageState extends State<ScenekitPage> {
  late ScenekitController scenekitController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CupertinoButton(
            child: const Icon(Icons.public_sharp, color: Colors.white),
            onPressed: () async {
              await scenekitController.addWidgetToScene();
            },
          ),
          CupertinoButton(
            child: const Icon(Icons.place, color: Colors.white),
            onPressed: () async {
              await scenekitController.addWidgetsToEarth(models: [
                ScenekitWidgetModel(
                  lat: 80,
                  long: 5,
                  name: "widgetNode1",
                  assetName: 'assets/eagle.png',
                  hexColor: 0x7FFF00,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode1 !");
                  },
                ),
                ScenekitWidgetModel(
                  lat: 43,
                  long: -85,
                  name: "widgetNode2",
                  assetName: 'assets/eagle.png',
                  hexColor: 0x7FFF00,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode2 !");
                  },
                ),
                ScenekitWidgetModel(
                  lat: -19,
                  long: 47,
                  name: "widgetNode3",
                  assetName: 'assets/eagle.png',
                  hexColor: 0x7FFF00,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode3 !");
                  },
                ),
              ]);
            },
          ),
          CupertinoButton(
            child: const Icon(Icons.display_settings_outlined,
                color: Colors.white),
            onPressed: () async {
              await scenekitController.dispose();
            },
          ),
        ]),
      ),
      body: _viewWithPlanet,
    );
  }

  Widget get _viewWithPlanet {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ScenekitView(
        onScenekitViewCreated: onScenekitViewCreated,
      ),
    );
  }

  void onScenekitViewCreated(ScenekitController scenekitController) {
    this.scenekitController = scenekitController;
  }

  @override
  void dispose() {
    scenekitController.dispose();
    super.dispose();
  }
}
