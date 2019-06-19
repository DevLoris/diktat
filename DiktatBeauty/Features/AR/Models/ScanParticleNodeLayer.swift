//
//  ScanParticleNodeLayer.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 19/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ScanParticlesNodeLayer: ParticlesNodeLayer {
    override var particleFile: String {
        get { return "ScannedParticles.scnp" }
    }
}
