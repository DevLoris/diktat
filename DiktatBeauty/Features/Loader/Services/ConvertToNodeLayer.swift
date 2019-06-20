//
//  ConvertToNodeLayer.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 15/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class ConvertToNodeLayer {
    // Create a new ImageNode and add it to the "Recognizated" singleton
    static func convertAndPopulate(object: NodeObject) {
        Recognitazed.instance.nodes[object.name] = convert(object: object)
    }
    
    // Convert a NodeObject to an ImageNode
    static func convert(object: NodeObject) -> ImageNode {
        let n = ImageNode(identifier: object.name, title: object.title, layers: [], text: object.text)

    
        
        // Loop over all the layers and instanciate/hydrate them
        object.layers.forEach { (node) in
            guard let nodeLayer = guessNodeLayerType(type: node.type) else { return }
            
            nodeLayer.hydrate(node: node)
            
            n.addLayer(layer: nodeLayer)
        }

        return n;
    }
    
    // Guess the type of a NodeLayer for a given type name
    static func guessNodeLayerType(type: String) -> CustomNodeLayer? {
        switch type {
            case "video":
                return VideoNodeLayer()
            case "gif":
                return ImageGifNodeLayer()
            case "particles":
                return ParticlesNodeLayer()
            default:
                return ImageNodeLayer()
        }
    }
}
