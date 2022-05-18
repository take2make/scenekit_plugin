# scenekit_plugin

Scenekit plugin allows you to render custom 3d models by using scenekit API in Flutter.

At the moment rootNode is the EarthNode, it means that all other nodes will be located
regarding it. 

Main gestures are transfered from the Flutter side to the Native side. Flutter catch the tap gesture
and allow to manipulate with widgets in the scene. As an example to this is WidgetNode.

WidgetNode can be modified:
1. Color (hex int format)
2. Image (send image in the base64 format from Flutter to Swift)
3. Location on the Earth (Latitude and Longitude)

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

| iOS | <img height="414" src="https://github.com/take2make/scenekit_plugin/example/screenshots/earth_with_widgets.gif">

## ❓ Usage

