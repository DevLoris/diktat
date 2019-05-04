//
//  ViewController+ARSessionDelegate.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

extension ViewController : ARSCNViewDelegate {
    func loadSessionDelegate() {
        sceneView.delegate = self
        sceneView.session.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the AR experience
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.pause()
    }
    
    
    func resetTracking() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        if #available(iOS 12.0, *) {
            configuration.maximumNumberOfTrackedImages = 1
        }
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        DispatchQueue.main.async {
            if let name = referenceImage.name {
                if let imgNode = self.nodes[name] {
                    imgNode.createNodes(parent: referenceImage).forEach { n in
                        node.addChildNode(n);
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            let imageName = referenceImage.name ?? ""
            self.imageNameLabel.text = imageName
            self.actualNode = imageName
        }
    }
    
    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            
            .fadeOpacity(to: 0.85, duration: 0.25)   /*,
             .fadeOut(duration: 0.5),
             .removeFromParentNode()*/
            ])
    }
}
