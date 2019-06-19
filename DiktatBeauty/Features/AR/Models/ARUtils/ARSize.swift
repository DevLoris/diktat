//
//  ARSize.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 01/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ARSize {
    var widthFactor: Float = 1
    var heightFactor: Float = 1
    
    init(widthFactor: Float, heightFactor: Float) {
        self.widthFactor = widthFactor
        self.heightFactor = heightFactor
    }
    
    init(_ widthFactor: Float, _ heightFactor: Float) {
        self.widthFactor = widthFactor
        self.heightFactor = heightFactor
    }
    
    func getSize() -> SCNVector3 {
        return SCNVector3(x: widthFactor, y: heightFactor, z: 1)
    }
    
    func createPlane(parent: ARReferenceImage) -> SCNPlane {
        return SCNPlane(
            width: parent.physicalSize.width * CGFloat(widthFactor),
            height: parent.physicalSize.height * CGFloat(heightFactor)
        )
    }
}
