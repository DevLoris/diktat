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
    var layers:[CustomNodeLayer]?;
    
    init(identifier: String, title: String, layers:[CustomNodeLayer]) {
        self.identifier = identifier
        self.title = title
        self.layers = layers;
    }
    
    init(layers:[CustomNodeLayer]) {
        self.layers = layers;
    }
    
    func addLayer(layer:CustomNodeLayer) {
        self.layers?.append(layer);
    }
    
    func createNodes(parent : ARReferenceImage) -> [SCNNode] {
        var nodes:[SCNNode] = [];
        
        self.layers?.forEach {  node in
            if let n = node.createNode(parent: parent) {
                nodes.append(n)
            }
        }
        
        return nodes;
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
