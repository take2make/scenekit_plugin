import UIKit
import SceneKit

class ImageNode: SCNNode {
    var image: UIImage?

    func initFromParameters(params: Dictionary<String, Any>) {
        if ((params["imageData"] as? String)! != "") {
            let imageData = Data(base64Encoded: (params["imageData"] as? String)!)
            self.image = UIImage(data: imageData!)
        }
    }

    init(params: Dictionary<String, Any>) {
        super.init()
        self.initFromParameters(params: params)
        let plane = SCNPlane(width: 0.2, height: 0.2)
        self.geometry = plane
        
        self.geometry?.firstMaterial?.diffuse.contents = self.image
        self.geometry?.firstMaterial?.shininess = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
