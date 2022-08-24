import UIKit
import SceneKit

class WidgetNode: SCNNode {
    var image: UIImage?
    
    func initFromParameters(params: Dictionary<String, Any>) {
        if ((params["imageData"] as? String)! != "") {
            let imageData = Data(base64Encoded: (params["imageData"] as? String)!)
            self.image = UIImage(data: imageData!)
        }
        self.name = (params["key"] as? String)!
    }

    init(params: Dictionary<String, Any>) {
        super.init()
        self.initFromParameters(params: params)
        let plane = SCNPlane(width: 0.3, height: 0.3)
        self.geometry = plane
        
        self.geometry?.firstMaterial?.diffuse.contents = self.image
        self.geometry?.firstMaterial?.shininess = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
