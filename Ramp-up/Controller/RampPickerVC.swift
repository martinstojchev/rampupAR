//
//  RampPickerVC.swift
//  Ramp-up
//
//  Created by Martin on 10/1/18.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {
    
    var sceneView: SCNView!
    var size: CGSize!
    
    //to prevent retain cycle with weak
    weak var rampPlacerVC: RampPlacerVC!
    
    
    init(size: CGSize){
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        preferredContentSize = size
        
        let scene = SCNScene(named: "art.scnassets/ramps.scn")
        sceneView.scene = scene
        
        //set the orthographic camera
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene?.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        
        
        //rotate the objects
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        
        
        var obj = SCNScene(named: "art.scnassets/pipe.dae")
        var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        node?.runAction(rotate)
        //scale the node
        node?.scale = SCNVector3Make(0.0019, 0.0019, 0.0019)
        node?.position = SCNVector3Make(-0, 1.1, -1)
        scene?.rootNode.addChildNode(node!)
        
        
        obj = SCNScene(named: "art.scnassets/pyramid.dae")
        node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)
        node?.runAction(rotate)
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-0, 0.35, -1)
        scene?.rootNode.addChildNode(node!)
        
        obj = SCNScene(named: "art.scnassets/quarter.dae")
        node = obj?.rootNode.childNode(withName: "quarter", recursively: true)
        node?.runAction(rotate)
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-0, -0.65, -1)
        scene?.rootNode.addChildNode(node!)
        
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer){
        
        //point for hit results(location)
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            print(node.name!)
            rampPlacerVC.onRampSelected(node.name!)
            
           
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
