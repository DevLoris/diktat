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
    var identifier = ""
    var title = ""
    var text = ""
    var layers: [CustomNodeLayer]?
    var nodes: [SCNNode]? = nil
    var rendered = false
    
    init(identifier: String, title: String, layers: [CustomNodeLayer], text: String = "") {
        self.identifier = identifier
        self.title = title
        self.layers = layers
        self.text = text
    }
    
    init(layers: [CustomNodeLayer]) {
        self.layers = layers
    }
    
    func addLayer(layer: CustomNodeLayer) {
        self.layers?.append(layer)
    }
    
    // Create all layers
    func createNodes(parent: ARReferenceImage) -> [SCNNode] {
        if let allNodes = nodes { return allNodes }
        
        var tempNodes: [SCNNode] = []
        
        self.layers?.forEach { node in
            if let n = node.createNode(parent: parent) {
                tempNodes.append(n)
            }
        }
    
        return tempNodes
    }
    
    func getLayers() -> [CustomNodeLayer]? {
        return self.layers
    }
    
    func getLayerById(identifier: String) -> CustomNodeLayer? {
        return self.layers?.first(where: { p -> Bool in
            return p.identifier == identifier
        })
    }
}
