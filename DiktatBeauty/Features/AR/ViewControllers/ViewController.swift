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
    
    //Timer utilisé pour le reset des images au bout de X secondes (si hors-screen)
    var timer: Timer!
    
    //Identifiant de l'ancre actuelle, pour voir si elle diffère plus tard
    var currentAnchorIdentifier : UUID?
    
    //Identifiant de la node actuelle
    var actualNode:String? = nil
    

    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    var session: ARSession {
        return sceneView.session
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loaded = ["anorexia", "maquillage"]
        loaded.forEach { (name) in
            NetworkManager.instance.getJson(name: name) { (node) in
                //Check si la node existe bien
                if let n = node {
                    //On converti la node et on l'ajoute au RECOGNIZATER
                    ConvertToNodeLayer.convertAndPopulate(object: n)
                }
            } 
        }
        
        loadSessionDelegate()
        // Do any additional setup after loading the view.
    }


    
    var isRestartAvailable = true
    
}

