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
        
        loadSessionDelegate()
        // Do any additional setup after loading the view.
    }


    
    var isRestartAvailable = true
    
    let nodes:[String:ImageNode] = [
        "test" : ImageNode(layers: [
            ImageNodeLayer(identifier: "background", material_name: "test-1", position: ARPosition(positionType: .RELATIVE, x: 0, y: 0.05, z: 0), size: ARSize(3, 1)),
            ImageNodeLayer(identifier: "left-image", material_name: "test-2", position: ARPosition(positionType: .RELATIVE, x: -0.66, y: 0.1, z: 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "right-star", material_name: "test-3", position: ARPosition(positionType: .ABSOLUTE, x: 0.66, y: 0.15, z: 0), size: ARSize(1, 1)),
            ImageNodeLayer(identifier: "right-image", material_name: "test-30240", position: ARPosition(positionType: .RELATIVE, x: 0.66, y: 0.1, z: 0), size: ARSize(1,1)),
            ImageNodeLayer(identifier: "left-star", material_name: "test-3", position: ARPosition(positionType: .ABSOLUTE, x: -0.66, y: 0.15, z: 0), size: ARSize(1, 1)),
            ImageNodeLayer(identifier: "logo-pikaend", material_name: "PIKAEND", position: ARPosition(positionType: .ABSOLUTE, x: 0, y: 0.25, z: 0), size: ARSize(0.6, 0.6)),
        //   VideoNodeLayer(material_name: "video", position: SCNVector3(0, 0, 0))
        ])
    ] 
}

