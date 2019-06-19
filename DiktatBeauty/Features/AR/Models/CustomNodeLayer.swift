//
//  CustomNodeLayer.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 14/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation 
import ARKit
import SceneKit

class CustomNodeLayer {
    var identifier: String
    var materialName: String
    var opacity: Float
    var position: ARPosition
    var rotation: SCNVector4
    var size = ARSize(widthFactor: 1, heightFactor: 1)
    var touch = [TouchEvent(type: .NONE, on: "this", duration: 1, delay: 0)]
    var hiddenDefault = false
    var node: SCNNode? = nil
    
    init(
        identifier: String,
        materialName: String,
        opacity: Float,
        position: ARPosition,
        rotation: SCNVector4,
        size: ARSize
    ) {
        self.identifier = identifier
        self.materialName = materialName
        self.opacity = opacity
        self.position = position
        self.rotation = rotation
        self.size =  size
    }
    
    convenience init() {
        self.init(
            identifier: "",
            materialName: "",
            opacity: 1,
            position: ARPosition(.RELATIVE,0,0,0),
            rotation: SCNVector4(0,0,0,0),
            size: ARSize(widthFactor: 1, heightFactor: 1)
        )
    }
    
    convenience init(identifier: String, materialName: String) {
        self.init(
            identifier: identifier,
            materialName: materialName,
            opacity: 1,
            position: ARPosition(.RELATIVE,0,0,0),
            rotation: SCNVector4(0,0,0,0),
            size: ARSize(widthFactor: 1, heightFactor: 1)
        )
    }
    
    convenience init(identifier: String, materialName: String, position: ARPosition) {
        self.init(
            identifier: identifier,
            materialName: materialName,
            opacity: 1,
            position: position,
            rotation: SCNVector4(0,0,0,0),
            size: ARSize(widthFactor: 1, heightFactor: 1)
        )
    }
    
    convenience init(identifier: String, materialName: String, position: ARPosition, size: ARSize) {
        self.init(
            identifier: identifier,
            materialName: materialName,
            opacity: 1,
            position: position,
            rotation: SCNVector4(0,0,0,0),
            size: size
        )
    }
    
    convenience init(identifier: String, materialName: String, position: ARPosition, opacity: Float) {
        self.init(
            identifier: identifier,
            materialName: materialName,
            opacity: opacity,
            position: position,
            rotation: SCNVector4(0,0,0,0),
            size: ARSize(widthFactor: 1, heightFactor: 1)
        )
    }
    
    func createNode(parent: ARReferenceImage) -> SCNNode? { return nil }
    
    func getIdentifier() -> String { return identifier }

    // Move the layer on the Y axis and make it appear
    func startAnimation(node: SCNNode) {
        SCNTransaction.animationDuration = 1.0
        node.opacity = CGFloat(opacity);
        node.position.y = position.y
    }
    
    // Create a plane node using the NodeLayer properties
    func getPlaneNode(scenePlane: SCNPlane, parent: ARReferenceImage) -> SCNNode {
        return SCNNode(
            geometry: scenePlane,
            opacity: CGFloat(self.opacity),
            position: self.position.getLayerPosition(parent: parent),
            rotation: self.rotation,
            name: self.identifier,
            scale: self.size.getSize(),
            isHidden: self.hiddenDefault
        )
    }
    
    // Hydrate NodeLayer properties from a NodeObject item
    func hydrate(node: NodeObjectNodes) {
        self.identifier = node.id
        self.materialName = node.material
        self.opacity = node.opacity
        self.hiddenDefault = node.hidden_default
        self.rotation = SCNVector4(node.rotation[0], node.rotation[1], node.rotation[2], 0)
        self.position = ARPosition(.RELATIVE, node.position[0], node.position[1], node.position[2])
        self.size = ARSize(widthFactor: node.size[0], heightFactor: node.size[1])
        self.touch = []
        
        // Click events
        node.click_event.forEach({ (clickEvent) in
            let effectFromValue = TouchEventEffects(rawValue: clickEvent.apply)
            
            if let effect = effectFromValue {
                self.touch.append(TouchEvent(type: effect, on: clickEvent.on, duration: clickEvent.duration, delay: clickEvent.delay))
            }
        })
    }
}

