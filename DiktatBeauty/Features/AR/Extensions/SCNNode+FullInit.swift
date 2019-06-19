//
//  SCNNode+FullInit.swift
//  DiktatBeauty
//
//  Created by Hugo on 19/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {
    convenience init(
        geometry: SCNGeometry,
        opacity: CGFloat,
        position: SCNVector3,
        rotation: SCNVector4,
        name: String,
        scale: SCNVector3,
        isHidden: Bool
    ) {
        self.init(geometry: geometry)
        
        self.opacity = opacity
        self.position = position
        self.rotation = rotation
        self.name = name
        self.scale = scale
        self.isHidden = isHidden
    }
}
