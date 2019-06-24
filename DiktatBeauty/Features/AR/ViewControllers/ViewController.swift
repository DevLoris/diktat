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

    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    // Timer used for the images reset after X seconds (if out of screen)
    var timer: Timer!
    
    // Identifier of the current anchor, used to check if the anchor changes later
    var currentAnchorIdentifier: UUID?
    
    // Identifier of the current Node
    var actualNode: String? = nil
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    
    var session: ARSession {
        return sceneView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let availablePosters = ["makeup", "anorexia"]
        
        // Load all available posters as from the api's JSONs
        availablePosters.forEach { (name) in
            NetworkManager.instance.getJson(name: name) { (node) in
                if let n = node {
                    // Convert the node and add it to the RECOGNIZATER
                    ConvertToNodeLayer.convertAndPopulate(object: n)
                }
            } 
        }
        
        loadSessionDelegate()
    }
    
    var isRestartAvailable = true
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "fromARToDetails",
            let destinationViewController = segue.destination as? HistoryArticleViewController,
            let actual = actualNode
        else {
                return
        }
        
        
        destinationViewController.node = Recognitazed.instance.nodes[actual] 
    }
    
    @IBAction func openDetailsFromAR(_ sender: Any) {
        //fromARToDetails
        performSegue(withIdentifier: "fromARToDetails", sender: self)
    }
    
}

