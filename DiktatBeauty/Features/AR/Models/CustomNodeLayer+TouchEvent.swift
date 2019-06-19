//
//  CustomNodeLayer+TouchEvent.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 15/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

extension CustomNodeLayer {
    func touchEvent(parent: ImageNode) {
        print("Touched: " + self.identifier)
        self.executeTouchEvent(parent: parent) 
    }
    
    private func executeTouchEvent(parent: ImageNode) {
        touch.forEach { touchItem in
            var target: CustomNodeLayer? = self
            
            if touchItem.on != "this" {
                target = parent.getLayerById(identifier: touchItem.on)
            }
            
            guard
                let t = target,
                let node = t.node
                else { return }
            
            let wait = SCNAction.wait(duration: Double(touchItem.delay))
            var action: SCNAction? = nil
            
            switch touchItem.type {
                case .NONE:
                    return
                case .FADEIN:
                    action = SCNAction.fadeOpacity(to: CGFloat(t.opacity), duration: Double(touchItem.duration))
                    break
                case .FADEOUT:
                    action = SCNAction.fadeOpacity(to: CGFloat(0), duration: Double(touchItem.duration))
                    break
                case .SHOW:
                    action = SCNAction.unhide()
                    break
                case .HIDE:
                    action = SCNAction.hide()
                    break
            }
            
            if let animationAction = action {
                node.runAction(SCNAction.sequence([wait, animationAction]))
            }
        }
    }
}
