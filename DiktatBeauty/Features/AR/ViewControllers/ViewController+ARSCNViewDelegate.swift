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
        
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = referenceImages
        if #available(iOS 12.0, *) {
            configuration.maximumNumberOfTrackedImages = 1
        }
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    
    //Obligé de faire de l'objective C
    @objc
    func imageLost(_ sender:Timer){
        destroy()
    }
    
    func destroy() {
        
        print("out")
        
        guard
            let actual = actualNode
            else { return }
        
        let node = Recognitazed.instance.nodes[actual]
        if node!.rendered {
            node?.nodes?.forEach({ (n) in
                n.removeFromParentNode()
            })
            node?.rendered = false
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        let referenceImage = imageAnchor.referenceImage
        
        DispatchQueue.main.async {
            if(self.timer != nil){
                self.timer.invalidate()
            }
            self.timer = Timer.scheduledTimer(timeInterval: 0.6 , target: self, selector: #selector(self.imageLost(_:)), userInfo: nil, repeats: false)
        }
        
        //si l'identifier de l'ancre est différent, alors on détruit le rendu actuel 
        if(self.currentAnchorIdentifier != imageAnchor.identifier &&
            self.currentAnchorIdentifier != nil
            && self.actualNode != nil){
            destroy()
        }

        
        updateQueue.async {
            if let name = referenceImage.name {
                
                if let imgNode = Recognitazed.instance.nodes[name] {
                    //On génère les nodes et on fait le rendu
                    imgNode.rendered = true
                    let generatedNodes = imgNode.createNodes(parent: referenceImage)
                    renderer.prepare(generatedNodes, completionHandler: { n in
                        generatedNodes.forEach { n in
                            DispatchQueue.main.async {
                                node.addChildNode(n);
                            }
                        }
                    })
                    
                    //On sauvegarde la node actuelle
                    self.actualNode =  referenceImage.name ?? ""
                    
                    //On applique le changement de label, obligé de retourner sur la queue principale
                    DispatchQueue.main.async { 
                        self.imageNameLabel.text = imgNode.title
                    }
                    //on update l'identifier
                    self.currentAnchorIdentifier = anchor.identifier 
                }
            }
        }
    }
}
