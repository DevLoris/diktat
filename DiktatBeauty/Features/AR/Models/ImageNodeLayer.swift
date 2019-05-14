//
//  ImageNodeLayer.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 05/04/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ImageNodeLayer  :  CustomNodeLayer {
   
    var animation:(SCNNode)->() = {x in}
    var clickEvent:(SCNNode)->() = {x in print(x.name ?? "??")}
    
    override func createNode(parent: ARReferenceImage) -> SCNNode{
        let scene_plane =  SCNPlane(width: parent.physicalSize.width ,
                                    height: parent.physicalSize.height  ) 
        //Materiel
        let material = SCNMaterial(); 
        material.diffuse.contents = UIImage(named: self.material_name);
        scene_plane.firstMaterial?.isDoubleSided = true
        scene_plane.materials = [material];
        
        //Node
        let plane_node = SCNNode(geometry: scene_plane)
        plane_node.opacity = CGFloat(self.opacity);
        plane_node.position = self.position.getLayerPosition(parent: parent, onInit: true)
        plane_node.rotation = self.rotation
        plane_node.scale = size.getSize()
        
        //On set le name
        plane_node.name = self.identifier
        
        plane_node.eulerAngles.x = -.pi / 2
        
        
       DispatchQueue.main.async {
            self.animation(plane_node)
            let finalPosition = self.position.getLayerPosition(parent: parent, onInit: false)
            let action = SCNAction.moveBy(x: CGFloat(finalPosition.x), y: CGFloat(finalPosition.y), z: CGFloat(finalPosition.z), duration: 1)
            plane_node.runAction(action)
        
        }
        
        return plane_node
    }
    
    
    func getIdentifier() -> String {
        return identifier;
    }
}
