//
//  ARPosition.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 01/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

enum ARPositionType: String {
    case ABSOLUTE = "absolute"
    case RELATIVE = "relative"
}

/* Class pour simplifier le position du calque, si relative à la taille de l'image, donc en pourcentage, ou bien absolute, donc en gardant les valeurs "pures" */
class ARPosition  {
    var positionType: ARPositionType = .RELATIVE
    var x: Float = 0
    var y: Float = 0
    var z: Float = 0
    
    init(_ positionType: ARPositionType, _ x: Float, _ y: Float, _ z: Float) {
        self.x = x
        self.y = y
        self.z = z
        self.positionType = positionType
    }
    
    func getLayerPosition(parent: ARReferenceImage, onInit: Bool = false) -> SCNVector3 {
        let posY = onInit ? 0 : y
        
        if positionType == .ABSOLUTE {
            return SCNVector3(x, posY, z)
        }
        
        return SCNVector3(
            x * Float(parent.physicalSize.width),
            posY,
            z * Float(parent.physicalSize.height)
        )
    }
}
