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
    var material_name: String
    var opacity: Float = 0
    var position = SCNVector3(0,0,0)
    var rotation = SCNVector4(0,0,0,0)
    var animation:(SCNNode)->() = {x in}
    
    init(material_name:String) {
        self.material_name = material_name
    }
    init(material_name:String, position:SCNVector3) {
        self.material_name = material_name
        self.position = position
    }
    init(material_name:String, opacity:Float) {
        self.material_name = material_name
        self.opacity = opacity
    }
    
    
    func createNode(parent: ARReferenceImage) -> SCNNode{
        let videoNode = SKVideoNode(fileNamed: "test.mp4")
        
        let skScene = SKScene(size: CGSize(width: 640, height: 480))
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
        videoNode.size = skScene.size
        
        let tvPlane = SCNPlane(width: parent.physicalSize.width, height: parent.physicalSize.width*0.75)
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        tvPlaneNode.position = self.position;
        tvPlaneNode.eulerAngles.x = .pi / 2
        
        DispatchQueue.main.async {
            
            videoNode.play()
        }
        return tvPlaneNode
    }
}
