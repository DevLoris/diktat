//
//  ImageGifNodeLayer.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 15/04/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ImageGifNodeLayer: CustomNodeLayer {
    override func createNode(parent: ARReferenceImage) -> SCNNode {
        let gifImageURL = Bundle.main.url(forResource: self.materialName, withExtension: "gif")
        let animation = GifHelper.getKeyfraymeAnimation(url: gifImageURL!)!
        
        // Create the layer containing the GIF and its animation
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        layer.add(animation, forKey: "contents")
        
        // Create material for the scene plane with the GIF layer
        let material = SCNMaterial();
        material.diffuse.contents = layer
        material.isDoubleSided = true
        
        let scenePlane = SCNPlane(
            width: parent.physicalSize.width,
            height: parent.physicalSize.height,
            withMaterial: material
        )
        
        return getPlaneNode(scenePlane: scenePlane, parent: parent)
    }
}
