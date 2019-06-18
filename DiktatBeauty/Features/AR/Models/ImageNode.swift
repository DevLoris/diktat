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
    var identifier:String = ""
    var title:String = ""
    var text:String = "bonjour"
    var layers:[CustomNodeLayer]?;
    var nodes:[SCNNode]? = nil
    var rendered = false
    
    init(identifier: String, title: String, layers:[CustomNodeLayer]) {
        self.identifier = identifier
        self.title = title
        self.layers = layers;
        
        let newParticle = ParticlesNodeLayer(identifier: "particles_test", material_name: "skullpardessus", position: ARPosition(.RELATIVE, 0, 0.6, 0), size: ARSize(1, 1));
        self.layers?.append(newParticle)
    }
    
    init(layers:[CustomNodeLayer]) {
        self.layers = layers;
    }
    
    func addLayer(layer:CustomNodeLayer) {
        self.layers?.append(layer);
    }
    
    func createNodes(parent : ARReferenceImage) -> [SCNNode] {
        if nodes == nil {
            var nodes_temp:[SCNNode] = []
            self.layers?.forEach {  node in
                if let n = node.createNode(parent: parent) {
                    nodes_temp.append(n)
                }
            }
            
            nodes = nodes_temp
        }
        
    
        return nodes!;
    }
    
    func getLayers() -> [CustomNodeLayer]? {
        return self.layers
    }
    
    func getLayerById(identifier:String) -> CustomNodeLayer? {
        return self.layers?.first(where: { (p) -> Bool in
            return p.identifier == identifier
        })
    }
}
