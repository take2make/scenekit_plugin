import UIKit
import SceneKit

class EmptyWidgetNode: SCNNode {
    override init() {
        super.init()
        let plane = SCNPlane(width: 0.2, height: 0.2)
        plane.cornerRadius = 0.05
        self.geometry = plane
        self.name = "widgetNode"
        
        self.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
        self.geometry?.firstMaterial?.shininess = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
