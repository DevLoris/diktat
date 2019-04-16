//
//  ImageNode.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 30/03/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ImageNode {
    var layers:[CustomNodeLayer]?;
    
    init(layers:[CustomNodeLayer]) {
        self.layers = layers;
    }
    
    func addLayer(layer:CustomNodeLayer) {
        self.layers?.append(layer);
    }
    
    func createNodes(parent : ARReferenceImage) -> [SCNNode] {
        var nodes:[SCNNode] = [];
        
        self.layers?.forEach {  node in
            nodes.append(node.createNode(parent: parent))
        }
        
        return nodes;
    }
}

protocol CustomNodeLayer {
    var material_name: String { get set }
    var opacity: Float { get set }
    var position : SCNVector3  { get set }
    var rotation : SCNVector4  { get set }
    
    func createNode(parent: ARReferenceImage) -> SCNNode;
    
}


/*
 let material = SCNMaterial();
 material.diffuse.contents = UIImage(named: "OK");
 
 let material_devil = SCNMaterial();
 material_devil.diffuse.contents = UIImage(named: "devil");
 
 // Create a plane to visualize the initial position of the detected image.
 let plane = SCNPlane(width: referenceImage.physicalSize.width,
 height: referenceImage.physicalSize.height)
 let planeNode = SCNNode(geometry: plane)
 plane.materials = [material];
 
 planeNode.opacity = 0.9
 planeNode.eulerAngles.x = -.pi / 2
 
 
 
 node.addChildNode(planeNode)
 */
