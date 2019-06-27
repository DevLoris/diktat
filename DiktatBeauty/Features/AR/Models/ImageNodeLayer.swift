//
//  ImageNodeLayer.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 05/04/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ImageNodeLayer: CustomNodeLayer {
    var animation: (SCNNode) -> Void = {x in}
    
    override func createNode(parent: ARReferenceImage) -> SCNNode {
        // Create the material
        let material = SCNMaterial(imageName: self.materialName)
        
        // Create a base plan for the node
        let scenePlane = SCNPlane(width: parent.physicalSize.width, height: parent.physicalSize.height, withMaterial: material)
        
        // Create the node
        let planeNode = getPlaneNode(withGeometry: scenePlane, parent: parent)
        planeNode.eulerAngles.x = -.pi / 2
        
        // Create animation and run action
        DispatchQueue.main.async {
            self.animation(planeNode)
            let finalPosition = self.position.getLayerPosition(parent: parent, onInit: false)
            let action = SCNAction.moveBy(x: CGFloat(finalPosition.x), y: CGFloat(finalPosition.y), z: CGFloat(finalPosition.z), duration: 1)
            planeNode.runAction(action)
        }
        
        node = planeNode
        
        return planeNode
    }
}
