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
    var position = ARPosition(positionType: .RELATIVE, x: 0, y: 0, z: 0)
    var size = ARSize(width_factor: 1, height_factor: 1)
    var rotation = SCNVector4(0,0,0,0)
    var animation:(SCNNode)->() = {x in}
    var clickEvent:(SCNNode)->() = {x in print(x.name)}
    var identifier:String 
    
    init(identifier:String, material_name:String) {
        self.identifier = identifier
        self.material_name = material_name
    }
    init(identifier:String, material_name:String, position:ARPosition, size:ARSize) {
        self.identifier = identifier
        self.material_name = material_name
        self.position = position
        self.size = size
    }
    init(identifier:String, material_name:String, opacity:Float) {
        self.identifier = identifier
        self.material_name = material_name
        self.opacity = opacity
    }
    
    
    func createNode(parent: ARReferenceImage) -> SCNNode{
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
        plane_node.position = self.position.getLayerPosition(parent: parent)
        plane_node.rotation = self.rotation
        plane_node.scale = size.getSize()
        
        //On set le name
        plane_node.name = self.identifier
        
        plane_node.eulerAngles.x = -.pi / 2
        
       /* DispatchQueue.main.async {
            self.animation(plane_node)
            let action = SCNAction.moveBy(x: 0, y: 20, z: 0, duration: 1)
            plane_node.runAction(action)
            
        }*/
        
        return plane_node
    }
    
    
    func getIdentifier() -> String {
        return identifier;
    }
}
