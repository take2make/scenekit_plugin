import UIKit
import SceneKit

class EarthNode: SCNNode {
    
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 1)
        
        //print(" latitude \(self.geometry?.emissionLatitude)")
        
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Diffuse")
        
        self.geometry?.firstMaterial?.shininess = 100
        
        /*
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)*/
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
