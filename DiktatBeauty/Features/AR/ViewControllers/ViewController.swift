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
    
    let imgNode = ImageNode(layers: [
        ImageNodeLayer(material_name: "test-1", position: SCNVector3(0, 0.05, 0)),
        ImageNodeLayer(material_name: "test-2", position: SCNVector3(0, 0.10, 0)),
        ImageNodeLayer(material_name: "test-3", position: SCNVector3(0, 0.15, 0)),
        //   VideoNodeLayer(material_name: "video", position: SCNVector3(0, 0, 0))
        ]);
    
    
}

