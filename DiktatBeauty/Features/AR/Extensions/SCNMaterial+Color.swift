//
//  SCNMaterial+Color.swift
//  DiktatBeauty
//
//  Created by Hugo on 18/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit

extension SCNMaterial {
    convenience init(color: UIColor) {
        self.init()
        diffuse.contents = color
    }
}
