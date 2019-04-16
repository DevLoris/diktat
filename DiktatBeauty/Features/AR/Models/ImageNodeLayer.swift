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
    var material_name: String
    var opacity: Float = 1
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
        let scene_plane = SCNPlane(width: parent.physicalSize.width,
                                   height: parent.physicalSize.height)
        
        //Materiel
        let material = SCNMaterial();
        material.diffuse.contents = UIImage(named: self.material_name);
        scene_plane.firstMaterial?.isDoubleSided = true
        scene_plane.materials = [material];
        
        //Node
        let plane_node = SCNNode(geometry: scene_plane)
        plane_node.opacity = CGFloat(self.opacity);
        plane_node.position = self.position
        plane_node.rotation = self.rotation
        
        plane_node.eulerAngles.x = -.pi / 2
        
       /* DispatchQueue.main.async {
            self.animation(plane_node)
            let action = SCNAction.moveBy(x: 0, y: 20, z: 0, duration: 1)
            plane_node.runAction(action)
            
        }*/
        
        return plane_node
    }
}
