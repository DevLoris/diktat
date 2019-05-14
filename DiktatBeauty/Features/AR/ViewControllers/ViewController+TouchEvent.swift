//
//  ViewController+TouchEvent.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 04/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        VERIFIE SI ON A BIEN CLIQUER SUR UNE NODE
        */
        guard let touchLocation = touches.first?.location(in: sceneView),
        let hitNode = sceneView?.hitTest(touchLocation, options: nil).first?.node,
        let nodeName = hitNode.name
        else {
            //No Node Has Been Tapped
            return
        }
        
        /*
        GESTION DES CLICKS EVENTS
         - Check si la node clickée est bien sur l'image
         - Itére les calques pour trouver l'événement qui correspond à l'identifier
         - Applique et lance le click Event
        */
        
        guard
            let actual = actualNode,
            let nodes = self.nodes[actual],
            let layers = nodes.getLayers()
        else {
            return
        }
        for node in layers {
            if node.identifier == nodeName, let imageNode = node as? ImageNodeLayer {
                imageNode.clickEvent(hitNode)
            }
        }
    }
}
