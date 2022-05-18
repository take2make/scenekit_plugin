import UIKit
import SceneKit

class FlutterScenekitView: NSObject, FlutterPlatformView, SCNSceneRendererDelegate {
    let sceneView: SCNView
    let channel: FlutterMethodChannel
    var forceTapOnCenter: Bool = false
    var parentNode: SCNNode?
    var radius: Float = 1.15
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, messenger msg: FlutterBinaryMessenger) {
        self.sceneView = SCNView(frame: frame)
        self.channel = FlutterMethodChannel(name: "scenekit_\(viewId)", binaryMessenger: msg)
        
        super.init()
        
        self.sceneView.delegate = self
        self.channel.setMethodCallHandler(self.onMethodCalled)
    }
    
    func view() -> UIView { return sceneView }
    
    func onMethodCalled(_ call :FlutterMethodCall, _ result:FlutterResult) {
        let arguments = call.arguments as? Dictionary<String, Any>
        
        switch call.method {
        case "init":
            initalize(arguments!, result)
            result(nil)
            break
        case "dispose":
            onDispose(result)
            result(nil)
            break
        case "handle_tap":
            let resTap = handleTap(point: Point.initFromParameters(params: arguments!))
            result(resTap)
            break
        case "add_widget_to_scene":
            let earthNode = EarthNode()
            self.parentNode = earthNode
            self.sceneView.scene!.rootNode.addChildNode(earthNode)
            result(nil)
            break
        case "add_widgets_to_earth":
            addWidgetsToEarth(arguments: arguments!)
            result(nil)
            break
        case "add_widget_to_earth":
            let widgetNode = WidgetNode(params: arguments!)
            addNodeToAnotherNode(parentNode: self.parentNode!, childNode: widgetNode, coord: Coord.initFromParameters(params: arguments!))
            addSymmetricNode(parentNode: self.parentNode!, childNode: EmptyWidgetNode(), coord: Coord.initFromParameters(params: arguments!))
            result(nil)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    func addWidgetsToEarth(arguments: Dictionary<String, Any>) {
        for widgetArgument in (arguments["widgets"] as? [Dictionary<String,Any>])! {
            let widgetNode = WidgetNode(params: widgetArgument)
            addNodeToAnotherNode(parentNode: self.parentNode!, childNode: widgetNode, coord: Coord.initFromParameters(params: widgetArgument))
            addSymmetricNode(parentNode: self.parentNode!, childNode: EmptyWidgetNode(), coord: Coord.initFromParameters(params: widgetArgument))
        }
    }

    func initalize(_ arguments: Dictionary<String, Any>, _ result:FlutterResult) {
        let scene = SCNScene()
        scene.background.contents = UIColor.clear
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x:0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)
        sceneView.pointOfView = cameraNode

        addUniformLight(scene:scene);

        if let showStatistics = arguments["showStatistics"] as? Bool {
            self.sceneView.showsStatistics = showStatistics
        }
        
        for reco in sceneView.gestureRecognizers! {
            if let panRecognizer = reco as? UIPanGestureRecognizer {
                panRecognizer.maximumNumberOfTouches = 1
            }
        }
        
        sceneView.scene = scene
        sceneView.defaultCameraController.maximumVerticalAngle = 45
        sceneView.defaultCameraController.minimumVerticalAngle = -45
        sceneView.allowsCameraControl = true
        sceneView.pointOfView?.camera?.usesOrthographicProjection = true
        sceneView.pointOfView?.camera?.orthographicScale = 4
        sceneView.cameraControlConfiguration.rotationSensitivity = 0.4
    }
    
    func handleTap(point: Point) -> String? {
        let location = CGPoint(x: point.x, y: point.y)
        let hits = self.sceneView.hitTest(location, options: nil)
        if let tappedNode = hits.first?.node {
            return tappedNode.name
        }
        return nil
    }

    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        let currentOrthographicScale = self.sceneView.pointOfView?.camera?.orthographicScale
        scene.rootNode.enumerateChildNodes { (node, stop) in
            if ( (node.name?.localizedStandardContains("widgetNode")) != nil &&  (node.name?.localizedStandardContains("widgetNode"))! ) {
                let floatScale = Float(currentOrthographicScale!)
                let normalizedScale = floatScale - 4
                print("scale = \(normalizedScale)")
                
                //node.position = SCNVector3(node.position.x, node.position.y,node.position.z)
                node.scale = SCNVector3(floatScale,floatScale,floatScale)
            }
        }
    }

    func addNodeToAnotherNode(parentNode: SCNNode, childNode: SCNNode, coord: Coord) {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = [.X, .Y, .Z]

        let pi = Float.pi

        childNode.position = SCNVector3(radius*cos(coord.latitude/180*pi)*sin(coord.longitude/180*pi),radius*sin(coord.latitude/180*pi), radius*cos(coord.latitude/180*pi)*cos(coord.longitude/180*pi));
        childNode.constraints = [billboardConstraint]
        parentNode.addChildNode(childNode)
    }
    
    func addSymmetricNode(parentNode: SCNNode, childNode: SCNNode, coord: Coord) {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = [.X, .Y, .Z]

        let pi = Float.pi

        childNode.position = SCNVector3(-radius*cos(coord.latitude/180*pi)*sin(coord.longitude/180*pi),-radius*sin(coord.latitude/180*pi), -radius*cos(coord.latitude/180*pi)*cos(coord.longitude/180*pi));
        childNode.constraints = [billboardConstraint]
        parentNode.addChildNode(childNode)
    }

    func addUniformLight(scene: SCNScene) {
        let lightNode1 = SCNNode()
        lightNode1.light = SCNLight()
        lightNode1.light?.type = .omni
        lightNode1.position = SCNVector3(x: 0, y: 0, z: -5)
        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light?.type = .omni
        lightNode2.position = SCNVector3(x: 0, y: 5, z: 0)
        
        let lightNode3 = SCNNode()
        lightNode3.light = SCNLight()
        lightNode3.light?.type = .omni
        lightNode3.position = SCNVector3(x: 0, y: -5, z: 0)
        
        let lightNode4 = SCNNode()
        lightNode4.light = SCNLight()
        lightNode4.light?.type = .omni
        lightNode4.position = SCNVector3(x: 5, y: 0, z: 0)
        
        let lightNode5 = SCNNode()
        lightNode5.light = SCNLight()
        lightNode5.light?.type = .omni
        lightNode5.position = SCNVector3(x: -5, y: 0, z: 0)
        
        let lightNode6 = SCNNode()
        lightNode6.light = SCNLight()
        lightNode6.light?.type = .omni
        lightNode6.position = SCNVector3(x: 0, y: 0, z: 5)
        
        scene.rootNode.addChildNode(lightNode1)
        scene.rootNode.addChildNode(lightNode2)
        scene.rootNode.addChildNode(lightNode3)
        scene.rootNode.addChildNode(lightNode4)
        scene.rootNode.addChildNode(lightNode5)
        scene.rootNode.addChildNode(lightNode6)

    }

    func onDispose(_ result:FlutterResult) {
        sceneView.isPlaying = false
        sceneView.scene?.isPaused = true
        sceneView.scene!.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        result(nil)
    }

}
