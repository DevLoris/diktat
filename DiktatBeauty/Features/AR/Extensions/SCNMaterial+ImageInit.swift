//
//  SCNMaterial+ImageInit.swift
//  DiktatBeauty
//
//  Created by Hugo on 19/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit

extension SCNMaterial {
    convenience init(imageName: String) {
        self.init()
        self.diffuse.contents = UIImage(named: imageName)
    }
}
