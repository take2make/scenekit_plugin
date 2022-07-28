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
                ScenekitWidgetModel(
                  key: "2",
                  lat: -10.714400586407978,
                  long: 142.45171148122125,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode2 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "3",
                  lat: -54.67741412802094,
                  long: -65.19909636841908,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode3 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "4",
                  lat: 30.26650857538525,
                  long: 19.178550279945366,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "5",
                  lat: 59.79306483603608,
                  long: -43.512201005381975,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "6",
                  lat: -54.34254260760243,
                  long: -36.68737356642335,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "7",
                  lat: 51.688418721938476,
                  long: -10.059464154101466,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "8",
                  lat: 14.544546883027087,
                  long: -17.266495078880997,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "9",
                  lat: -35.0809991322161,
                  long: 19.823347917559392,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "10",
                  lat: 24.949494347475582,
                  long: -80.547744158745,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "11",
                  lat: 65.4871246953433,
                  long: -167.91102409993078,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "12",
                  lat: 7.9975352096089445,
                  long: 77.4795990677296,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
                  },
                ),
                ScenekitWidgetModel(
                  key: "13",
                  lat: 71.110827193202,
                  long: 25.624130516034786,
                  assetName: 'assets/eagle.png',
                  color: 0xFFFF00FF,
                  onWidgetTap: () async {
                    await HapticFeedback.lightImpact();
                    print("navigate to widgetNode4 !");
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
