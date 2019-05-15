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
    var material_name: String
    var opacity: Float
    var position : ARPosition
    var rotation : SCNVector4
    var size = ARSize(width_factor: 1, height_factor: 1)
    var touch = [TouchEvent(type: .NONE, on: "this", duraction: 1, delay: 0)]
    var hiddenDefault = false
    var node:SCNNode? = nil
    
    init(identifier:String, material_name:String, opacity:Float, position:ARPosition, rotation:SCNVector4, size:ARSize) {
        self.identifier = identifier
        self.material_name = material_name
        self.opacity = opacity
        self.position = position
        self.rotation = rotation
        self.size =  size
    }
    
    
    convenience init(identifier: String,material_name:String) {
        self.init(identifier: identifier, material_name: material_name, opacity: 1, position: ARPosition(.RELATIVE,0,0,0), rotation: SCNVector4(0,0,0,0), size: ARSize(width_factor: 1, height_factor: 1))
    }
    convenience init() {
        self.init(identifier: "", material_name: "", opacity: 1, position: ARPosition(.RELATIVE,0,0,0), rotation: SCNVector4(0,0,0,0), size: ARSize(width_factor: 1, height_factor: 1))
    }
    convenience init(identifier: String,material_name:String, position:ARPosition) {
        self.init(identifier: identifier, material_name: material_name, opacity: 1, position:  position, rotation: SCNVector4(0,0,0,0),   size:ARSize(width_factor: 1, height_factor: 1))
    }
    convenience init(identifier: String,material_name:String, position:ARPosition, size: ARSize) {
        self.init(identifier: identifier, material_name: material_name, opacity: 1, position:   position, rotation: SCNVector4(0,0,0,0),  size: size)
    }
    convenience init(identifier: String,material_name:String, position:ARPosition, opacity:Float) {
        self.init(identifier: identifier, material_name: material_name, opacity: opacity, position:   position, rotation: SCNVector4(0,0,0,0),  size: ARSize(width_factor: 1, height_factor: 1))
    }
    
    
    func createNode(parent: ARReferenceImage) -> SCNNode? { return nil };
    
    func startAnimation(node:SCNNode) {
        SCNTransaction.animationDuration = 1.0
        node.opacity = CGFloat(opacity);
        node.position.y = position.y
    }
     
}

