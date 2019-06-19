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
        // Check if the target of the touch is a node
        guard
            let touchLocation = touches.first?.location(in: sceneView),
            let hitNode = sceneView?.hitTest(touchLocation, options: nil).first?.node,
            let nodeName = hitNode.name
        else { return }
        
        guard
            let actual = actualNode,
            let poster = Recognitazed.instance.nodes[actual],
            let layers = poster.getLayers()
        else { return }
        
        // Loop over the layers of the current poster and call the touchEvent method on the right layer
        for node in layers {
            if node.identifier == nodeName {
                node.touchEvent(parent: poster)
            }
        }
    }
}
