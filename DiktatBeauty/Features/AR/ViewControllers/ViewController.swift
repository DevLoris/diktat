//
//  ViewController.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var actualNode:String? = nil
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    var session: ARSession {
        return sceneView.session
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.instance.getJson { (node) in
            //Check si la node existe bien
            if let n = node {
                //On converti la node et on l'ajoute au RECOGNIZATER
                ConvertToNodeLayer.convertAndPopulate(object: n)
            }
        }
        
        loadSessionDelegate()
        // Do any additional setup after loading the view.
    }


    
    var isRestartAvailable = true
    
    let nodes:[String:ImageNode] = [
        "test" : ImageNode(layers: [
            ImageNodeLayer(identifier: "background", material_name: "test-1", position: ARPosition(.RELATIVE, 0, 0.05, 0), size: ARSize(3, 1)),
            ImageNodeLayer(identifier: "left-image", material_name: "test-2", position: ARPosition(.RELATIVE, -0.66, 0.1, 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "right-star", material_name: "test-3", position: ARPosition(.ABSOLUTE, 0.66, 0.15, 0), size: ARSize(1, 1)),
            ImageNodeLayer(identifier: "right-image", material_name: "test-30240", position: ARPosition(.RELATIVE, 0.66, 0.1, 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "left-star", material_name: "test-3", position: ARPosition(.ABSOLUTE, -0.66, 0.15, 0), size: ARSize(1, 1)),
            ImageNodeLayer(identifier: "logo-pikaend", material_name: "PIKAEND", position: ARPosition(.ABSOLUTE, 0, 0.25, 0), size: ARSize(0.6, 0.6)),
        //   VideoNodeLayer(material_name: "video", position: SCNVector3(0, 0, 0))
        ]),
        
        "anorexia" : ImageNode(layers: [
            ImageNodeLayer(identifier: "background", material_name: "femme-fond2", position: ARPosition(.RELATIVE, 0, 0.05, 0), size: ARSize(1, 1)),
            ImageGifNodeLayer(identifier: "plantes_v2", material_name: "test", position: ARPosition(.RELATIVE, 0, 0.1, 0)),
            //ImageNodeLayer(identifier: "plantes", material_name: "touteslesplantes", position: ARPosition(.RELATIVE, 0, 0.1, 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "femme", material_name: "femme-fond", position: ARPosition(.RELATIVE, 0, 0.3, 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "skull", material_name: "skullpardessus", position: ARPosition(.RELATIVE, 0, 0.5, 0), size: ARSize(1,1)),
            
            ])
    ] 
}

