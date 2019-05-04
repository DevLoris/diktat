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

enum ARPositionType : String {
    case ABSOLUTE = "absolute"
    case RELATIVE = "relative"
}

/* Class pour simplifier le position du calque, si relative à la taille de l'image, donc en pourcentage, ou bien absolute, donc en gardant les valeurs "pures" */
class ARPosition  {
    var positionType:ARPositionType = .RELATIVE
    var x:Float = 0
    var y:Float = 0
    var z:Float = 0
    
    init(positionType:ARPositionType, x:Float, y:Float, z:Float) {
        self.x = x
        self.y = y
        self.z = z
        self.positionType = positionType
    }
    
    func getLayerPosition(parent: ARReferenceImage) -> SCNVector3 {
        if positionType == .RELATIVE {
            return SCNVector3(x*Float(parent.physicalSize.width), y, z*Float(parent.physicalSize.height))
        }
        
        return SCNVector3(x, y, z)

    }
}