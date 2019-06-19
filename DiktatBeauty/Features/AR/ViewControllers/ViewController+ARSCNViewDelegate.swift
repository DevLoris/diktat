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
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the AR experience
        prepareSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.pause()
    }

    // Check if everything is ready to start the session and run it
    func prepareSession() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = referenceImages
        
        if #available(iOS 12.0, *) {
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        initTimer()
        
        // If the anchor identifier is different, destroy the actual render
        if (self.currentAnchorIdentifier != imageAnchor.identifier &&
            self.currentAnchorIdentifier != nil
            && self.actualNode != nil){
            destroy()
        }

        renderDetectedPoster(referenceImage: imageAnchor.referenceImage, renderer: renderer, node: node, anchor: anchor)
    }
    
    // Set the timer which calls the destroy method when the image is lost for too long
    func initTimer() {
        DispatchQueue.main.async {
            if self.timer != nil {
                self.timer.invalidate()
            }
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.imageLost(_:)), userInfo: nil, repeats: false)
        }
    }
    
    @objc
    func imageLost(_ sender:Timer){
        destroy()
    }
    
    // Destroy all the layers
    func destroy() {
        guard let actual = actualNode else { return }
        
        let posterNode = Recognitazed.instance.nodes[actual]
        
        if posterNode!.rendered {
            posterNode?.nodes?.forEach({ (n) in
                n.removeFromParentNode()
            })
            
            posterNode?.rendered = false
        }
    }
    
    func renderDetectedPoster(referenceImage: ARReferenceImage, renderer: SCNSceneRenderer, node: SCNNode, anchor: ARAnchor) {
        updateQueue.async {
            guard
                let name = referenceImage.name,
                let posterNode = Recognitazed.instance.nodes[name]
            else { return }
            
            posterNode.rendered = true
            
            // Generate all the nodes of the detected poster
            let generatedNodes = posterNode.createNodes(parent: referenceImage)
            
            // Add generated nodes to the target SCNNode
            renderer.prepare(generatedNodes, completionHandler: { n in
                generatedNodes.forEach { n in
                    DispatchQueue.main.async {
                        node.addChildNode(n);
                    }
                }
            })
            
            // Add the poster in the history
            Historized.instance.addViewedPoster(posterNode)
            
            self.actualNode =  referenceImage.name ?? ""
            self.currentAnchorIdentifier = anchor.identifier
        }
    }
}
