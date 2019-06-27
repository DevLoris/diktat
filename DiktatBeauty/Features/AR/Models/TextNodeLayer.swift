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

class TextNodeLayer: CustomNodeLayer {
    var text: String = ""
    
    var animation: (SCNNode) -> Void = {x in}
    
    override func createNode(parent: ARReferenceImage) -> SCNNode {
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.4
        let labelNode = SKLabelNode(text: "Hello World")
        labelNode.fontSize = 20
        labelNode.fontName = "San Fransisco"
        labelNode.position = CGPoint(x:100,y:100)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        
        let plane = SCNPlane(width: 20, height: 20, withMaterial: material)
        let planeNode = getPlaneNode(withGeometry: plane, parent: parent)
        
        node = planeNode
        
        return planeNode
    }
}
