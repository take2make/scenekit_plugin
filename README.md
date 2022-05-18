# scenekit_plugin

An iOS plugin to render 3d models in SceneKit iOS.

## Table of contents

- **[📱 Supported platforms](#-supported-platforms)**
- **[✨ Features](#-features)**
- **[📷 Screenshots](#-screenshots)**
- **[❓ Usage](#-usage)**

## 📱 Supported platforms

* **iOS 9.0+**.

## ✨ Features

* 3D Earth
* Ability to add widgets to 3D Earth
* Tap on widgets
* Show images in widgets
* Dispose scene

## 📷 Screenshots

| iOS | <img height="414" src="https://github.com/take2make/scenekit_plugin/blob/main/example/screenshots/earth_with_widgets.gif">

## ❓ Usage

* Init scenekit view

```dart

    late ScenekitController scenekitController;

    ScenekitView(
        onScenekitViewCreated: onScenekitViewCreated,
    ),

    void onScenekitViewCreated(ScenekitController scenekitController) {
        this.scenekitController = scenekitController;
    }
```

* Place Earth in the scene

```dart
    scenekitController.addWidgetToScene();
```

* Place Widget on the Earth

```dart
    scenekitController.addWidgetToEarth(model:
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
    )
```

