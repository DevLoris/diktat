//
//  SCNPlane+Material.swift
//  DiktatBeauty
//
//  Created by Hugo on 19/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit

extension SCNPlane {
    convenience init(width: CGFloat, height: CGFloat, withMaterial material: SCNMaterial, isDoubleSided: Bool = true) {
        self.init(width: width, height: height)
        self.firstMaterial?.isDoubleSided = true
        self.materials = [material]
    }
}
