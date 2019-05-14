//
//  VideoNodeLayer.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class VideoNodeLayer :  CustomNodeLayer {
    var animation:(SCNNode)->() = {x in}
    
    
    override func createNode(parent: ARReferenceImage) -> SCNNode{
        let videoNode = SKVideoNode(fileNamed: "test.mp4")
        
        let skScene = SKScene(size: CGSize(width: 640, height: 480))
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
        videoNode.size = skScene.size
        
        let tvPlane = SCNPlane(width: parent.physicalSize.width, height: parent.physicalSize.width*0.75)
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        tvPlaneNode.position = self.position.getLayerPosition(parent: parent);
        tvPlaneNode.eulerAngles.x = .pi / 2
        
    
        //On set le name
        tvPlaneNode.name = self.identifier
        
        DispatchQueue.main.async {
            
            videoNode.play()
        }
        return tvPlaneNode
    }
    
    func getIdentifier() -> String {
        return identifier;
    }
}
