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
    var position = ARPosition(positionType: .RELATIVE, x: 0, y: 0, z: 0)
    var rotation = SCNVector4(0,0,0,0)
    var animation:(SCNNode)->() = {x in}
    var identifier: String
    
    
    init(identifier:String, material_name:String) {
        self.identifier = identifier
        self.material_name = material_name
    }
    init(identifier:String, material_name:String, position:ARPosition) {
        self.identifier = identifier
        self.material_name = material_name
        self.position = position
    }
    init(identifier:String, material_name:String, opacity:Float) {
        self.identifier = identifier
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
