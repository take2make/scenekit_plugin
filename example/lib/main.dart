import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scenekit_plugin/controller/scenekit_plugin_controller_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ScenekitPage());
  }
}

class ScenekitPage extends StatefulWidget {
  const ScenekitPage({Key? key}) : super(key: key);

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
              await scenekitController.addEarthToScene(
                initialScale: 1.5,
                backgroundColor: 0xff1E3968,
              );
            },
          ),
          CupertinoButton(
            child: const Icon(Icons.place, color: Colors.white),
            onPressed: () async {
              await scenekitController.setWidgetsToEarth(models: [
                ScenekitWidgetModel(
                  key: "1",
                  lat: 50.83807146055582,
                  long: 156.87842152770136,
                  assetName: 'assets/eagle.png',
                  color: 0xFFBCD9A5,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode1 !");
                  },
                ),
              ]);
            },
          ),
          CupertinoButton(
            child: const Icon(Icons.display_settings_outlined,
                color: Colors.white),
            onPressed: () async {
              await scenekitController.removeWidgets();
            },
          ),
        ]),
      ),
      body: _viewWithPlanet,
    );
  }

  Widget get _viewWithPlanet {
    return SizedBox(
      child: ScenekitView(
        isAllowedToInteract: true,
        onScenekitViewCreated: onScenekitViewCreated,
      ),
    );
  }

  void onScenekitViewCreated(ScenekitController scenekitController) async {
    this.scenekitController = scenekitController;
    final version = await scenekitController.getPlatformVersion();
    await scenekitController.addEarthToScene(
      initialScale: 0.62, // full
      // initialScale: 0.9, // 300
      backgroundColor: 0xff1E3968,
      // y: -0.45
    );
    print(version);
  }

  @override
  void dispose() {
    //scenekitController.dispose();
    super.dispose();
  }
}
