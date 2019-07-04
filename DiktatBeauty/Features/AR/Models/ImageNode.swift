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
    var subtitle = ""
    var layers: [CustomNodeLayer]?
    var nodes: [SCNNode]? = nil
    var rendered = false
    
    init(identifier: String, title: String, layers: [CustomNodeLayer], text: String = "", subtitle: String = "") {
        self.identifier = identifier
        self.title = title
        self.layers = layers
        self.text = text
        self.subtitle = subtitle
        addTextDescriptionLayers()
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
    
    func addTextDescriptionLayers() {
        let textTriggerLayer = ImageNodeLayer(identifier: identifier + "_text_trigger", materialName: "text_trigger", position: ARPosition(.RELATIVE,0.375,0.05,0), size: ARSize(widthFactor: 0.5, heightFactor: 1))
        
        if let effect = TouchEventEffects(rawValue: "FADEOUT") {
            textTriggerLayer.touch.append(TouchEvent(type: effect, on: "this", duration: 1, delay: 0))
        }
        if let effect = TouchEventEffects(rawValue: "SHOW") {
            textTriggerLayer.touch.append(TouchEvent(type: effect, on: identifier + "_text", duration: 0, delay: 0))
        }
        if let effect = TouchEventEffects(rawValue: "FADEIN") {
            textTriggerLayer.touch.append(TouchEvent(type: effect, on: identifier + "_text", duration: 0.5, delay: 0))
        }
        self.layers?.append(textTriggerLayer)
        
        
        let textLayer = ImageNodeLayer(identifier: identifier + "_text", materialName: identifier + "_text", position: ARPosition(.RELATIVE,0.375,0.06,0), size: ARSize(widthFactor: 0.5, heightFactor: 1))
        textLayer.hiddenDefault = true
        if let effect = TouchEventEffects(rawValue: "FADEIN") {
            textLayer.touch.append(TouchEvent(type: effect, on: identifier + "_text_trigger", duration: 0.5, delay: 0))
        }
        if let effect = TouchEventEffects(rawValue: "FADEOUT") {
            textLayer.touch.append(TouchEvent(type: effect, on: "this", duration: 1, delay: 0))
        }
        if let effect = TouchEventEffects(rawValue: "HIDE") {
            textLayer.touch.append(TouchEvent(type: effect, on: "this", duration: 0, delay: 1))
        }
        self.layers?.append(textLayer)
    }
}
