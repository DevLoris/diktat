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
    static func convertAndPopulate(object: NodeObject) {
        Recognitazed.instance.nodes[object.name] = convert(object: object)
    }
    
    static func convert(object: NodeObject)->ImageNode {
        let n = ImageNode(identifier: object.name, title: object.title, layers: [])

        object.layers.forEach { (node) in
            guard let nodeLayer = guessNodeLayerType(type: node.type) else {
                return
            }
            
            nodeLayer.hydrate(node: node)
            
            n.addLayer(layer: nodeLayer)
        }

        return n;
    }
    
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
