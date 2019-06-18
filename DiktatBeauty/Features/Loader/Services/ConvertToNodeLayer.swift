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
    static func convertAndPopulate(object:NodeObject) {
        Recognitazed.instance.nodes[object.name] = convert(object: object)
    }
    
    static func convert(object:NodeObject)->ImageNode {
        let n = ImageNode(identifier: object.name, title: object.title, layers: [])

        object.layers.forEach { (node) in
            var customNodeLayer:CustomNodeLayer? = nil
            
            switch node.type {
            case "video":
                customNodeLayer = VideoNodeLayer()
            case "gif":
                customNodeLayer = ImageGifNodeLayer()
            case "particles":
                customNodeLayer = ParticlesNodeLayer()
            default:
                customNodeLayer = ImageNodeLayer()
            }
            
            if let nodeLayer = customNodeLayer {
                nodeLayer.identifier = node.id
                nodeLayer.material_name = node.material
                nodeLayer.opacity = node.opacity
                nodeLayer.hiddenDefault = node.hidden_default
                nodeLayer.rotation = SCNVector4(node.rotation[0],node.rotation[1],node.rotation[2],0)
                nodeLayer.position = ARPosition(.RELATIVE, node.position[0], node.position[1], node.position[2])
                nodeLayer.size = ARSize(width_factor: node.size[0], height_factor:  node.size[1])
                
                nodeLayer.touch = []
                //Events de click
                node.click_event.forEach({ (click_event) in
                    let effectFromValue = TouchEventEffects(rawValue: click_event.apply)
                    if let effect = effectFromValue {
                        nodeLayer.touch.append(TouchEvent(type: effect, on: click_event.on, duraction: click_event.duration, delay: click_event.delay))
                    }
                })
                
                n.addLayer(layer: nodeLayer)
            }
        }

        return n;
    }
}
