//
//  ParticleNodeLayer.swift
//  DiktatBeauty
//
//  Created by Hugo on 14/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//
 
import Foundation
import ARKit
import SceneKit

class ParticlesNodeLayer: CustomNodeLayer {
    var animation: (SCNNode) -> Void = {x in}
    var particleFile:String {
        get { return "Particles.scnp" }
    }
    
    
    override func createNode(parent: ARReferenceImage) -> SCNNode?{
        // Create an invisible material
        let material = SCNMaterial(color: .clear)
        
        // Create the scene plane
        let scenePlane = SCNPlane(width: parent.physicalSize.width, height: parent.physicalSize.height, withMaterial: material)
        
        // Create the plane node
        let plane_node = getPlaneNode(withGeometry: scenePlane, parent: parent)
        plane_node.eulerAngles.x = -.pi / 2
        
        // Create the particles system and set init values
        let particles = SCNParticleSystem(named: particleFile, inDirectory: nil)!
        particles.emitterShape = scenePlane
        particles.orientationMode = .free
        particles.particleImage = UIImage(named: self.materialName)
        plane_node.addParticleSystem(particles)
        
        // Create animation and run action
        DispatchQueue.main.async {
            self.animation(plane_node)
            let finalPosition = self.position.getLayerPosition(parent: parent, onInit: false)
            let action = SCNAction.moveBy(x: CGFloat(finalPosition.x), y: CGFloat(finalPosition.y), z: CGFloat(finalPosition.z), duration: 1)
            plane_node.runAction(action)
        }
        
        node = plane_node
        
        return plane_node
    }
}
