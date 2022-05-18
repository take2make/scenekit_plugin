import UIKit
import SceneKit

class WidgetNode: SCNNode {
    var color: UIColor = UIColor.red

    func initFromParameters(params: Dictionary<String, Any>) {
        if (params["hexColor"] != nil) {
            self.color = UIColor.init(rgb: (params["hexColor"] as? Int)!)
        }
        self.name = (params["widgetName"] as? String)!
    }

    init(params: Dictionary<String, Any>) {
        super.init()
        self.initFromParameters(params: params)
        let plane = SCNPlane(width: 0.2, height: 0.2)
        plane.cornerRadius = 0.05
        self.geometry = plane
        
        self.geometry?.firstMaterial?.diffuse.contents = self.color
        self.geometry?.firstMaterial?.shininess = 100
        
        let imageNode = ImageNode(params: params)
        self.addChildNode(imageNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
