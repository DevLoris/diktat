//
//  ParticleNodeLayer.swift
//  DiktatBeauty
//
//  Created by Hugo on 14/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation

import Foundation
import ARKit
import SceneKit

class ParticlesNodeLayer : CustomNodeLayer {
    
    var animation:(SCNNode)->() = {x in}
    
    override func createNode(parent: ARReferenceImage) -> SCNNode?{
        print("particles");
        
        let scene_plane =  SCNPlane(width: parent.physicalSize.width ,
                                    height: parent.physicalSize.height  )
        
        
        let plane_node = SCNNode(geometry: scene_plane)
        plane_node.opacity = CGFloat(0);
        plane_node.position = self.position.getLayerPosition(parent: parent, onInit: true)
        plane_node.rotation = self.rotation
        plane_node.scale = size.getSize()
        
        plane_node.isHidden = self.hiddenDefault
        
        //On set le name
        plane_node.name = self.identifier
        
        plane_node.eulerAngles.x = -.pi / 2
        
        let particles = SCNParticleSystem(named: "Particle.scnp", inDirectory: nil)!
        particles.emitterShape = scene_plane
        particles.particleImage = UIImage(named: self.material_name)
        plane_node.addParticleSystem(particles)
        
        DispatchQueue.main.async {
            self.animation(plane_node)
            let finalPosition = self.position.getLayerPosition(parent: parent, onInit: false)
            let action = SCNAction.moveBy(x: CGFloat(finalPosition.x), y: CGFloat(finalPosition.y), z: CGFloat(finalPosition.z), duration: 1)
            plane_node.runAction(action)
            
        }
        
        node = plane_node
        
        return plane_node
    }
    
    
    func getIdentifier() -> String {
        return identifier;
    }
}
