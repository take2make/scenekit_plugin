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
4. 

