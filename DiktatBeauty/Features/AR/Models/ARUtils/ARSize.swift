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
    var width_factor:Float = 1
    var height_factor:Float = 1
    
    init(width_factor:Float, height_factor:Float) {
        self.width_factor = width_factor
        self.height_factor = height_factor
    }
    
    init(_ width_factor:Float, _ height_factor:Float) {
        self.width_factor = width_factor
        self.height_factor = height_factor
    }
    
    func getSize() -> SCNVector3 {
        return SCNVector3(x: width_factor, y: height_factor, z: 1)
    }
    
    func createPlane(parent:ARReferenceImage) -> SCNPlane {
        return SCNPlane(width: parent.physicalSize.width * CGFloat(width_factor),
                        height: parent.physicalSize.height * CGFloat(height_factor))
    }
}
