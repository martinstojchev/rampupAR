//
//  Ramp.swift
//  Ramp-up
//
//  Created by Martin on 10/1/18.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import SceneKit

class Ramp {
    
    class func getRampForName(rampName: String)-> SCNNode {
        
        switch rampName {
        case "pipe":
            return Ramp.getPipe()
        case "quarter":
            return Ramp.getQuarter()
        case "pyramid":
            return Ramp.getPyramid()
            
        default:
            return Ramp.getPipe()
            
        }
    }
    
    class func getPipe() -> SCNNode {
        
        let obj = SCNScene(named: "art.scnassets/pipe.dae")
        let node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        node?.scale = SCNVector3Make(0.0019, 0.0019, 0.0019)
        node?.position = SCNVector3Make(-0, 1.1, -1)
        return node!
    }
    
    class func getPyramid() -> SCNNode {
        
        let obj = SCNScene(named: "art.scnassets/pyramid.dae")
        let node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-0, 0.35, -1)
        return node!
        
    }
    
    
    class func getQuarter() -> SCNNode {
        
        let obj = SCNScene(named: "art.scnassets/quarter.dae")
        let node = obj?.rootNode.childNode(withName: "quarter", recursively: true)
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-0, -0.65, -1)
        return node!
    }
    
    class func startRotation(node: SCNNode){
        
        //rotate the objects
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        node.runAction(rotate)
    }
    
    
    
}
