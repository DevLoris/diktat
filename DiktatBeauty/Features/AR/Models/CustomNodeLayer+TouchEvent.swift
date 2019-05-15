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
    func touchEvent(parent:ImageNode) {
        print(self.identifier)
        self.executeTouchEvent(parent: parent) 
    }
    
    private func executeTouchEvent(parent:ImageNode) {
        touch.forEach { (touch_item) in
            var target:CustomNodeLayer? = nil
            if(touch_item.on == "this") {
                target = self
            }
            else {
                target = parent.getLayerById(identifier: touch_item.on)
            }
            
            if let t = target, let node = t.node {
                switch touch_item.type {
                case .NONE:
                    return;
                case .FADEIN:
                    let w = SCNAction.wait(duration: Double(touch_item.delay))
                    let f = SCNAction.fadeOpacity(to: CGFloat(t.opacity), duration: Double(touch_item.duraction))
                    node.runAction(SCNAction.sequence([w,f]))
                    return;
                case .FADEOUT:
                    let w = SCNAction.wait(duration: Double(touch_item.delay))
                    let f = SCNAction.fadeOpacity(to: CGFloat(0), duration: Double(touch_item.duraction))
                    node.runAction(SCNAction.sequence([w,f]))
                    return;
                case .SHOW:
                    let w = SCNAction.wait(duration: Double(touch_item.delay))
                    let f = SCNAction.unhide()
                    node.runAction(SCNAction.sequence([w,f]))
                    return;
                case .HIDE:
                    let w = SCNAction.wait(duration: Double(touch_item.delay))
                    let f = SCNAction.hide()
                    node.runAction(SCNAction.sequence([w,f])) 
                    return;
                default:
                    return;
                }
            }
        }
    }
}
