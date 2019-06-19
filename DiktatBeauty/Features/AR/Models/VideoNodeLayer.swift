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

// -- WIP --
class VideoNodeLayer: CustomNodeLayer {
    var animation: (SCNNode) -> Void = {x in}
    
    // Demo values for now
    override func createNode(parent: ARReferenceImage) -> SCNNode{
        // Create the video node
        let videoNode = SKVideoNode(fileNamed: "test.mp4")
        
        // Create a scene and give it the video scene
        let skScene = SKScene(size: CGSize(width: 640, height: 480))
        skScene.addChild(videoNode)
        videoNode.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
        videoNode.size = skScene.size
        
        // Create a plane for the scene
        let tvPlane = SCNPlane(width: parent.physicalSize.width, height: parent.physicalSize.width * 0.75)
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
        // Create a node from the plane
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        tvPlaneNode.position = self.position.getLayerPosition(parent: parent)
        tvPlaneNode.name = self.identifier
        tvPlaneNode.eulerAngles.x = .pi / 2
        
        DispatchQueue.main.async {
            videoNode.play()
        }
        
        node = tvPlaneNode
        
        return tvPlaneNode
    }
}
