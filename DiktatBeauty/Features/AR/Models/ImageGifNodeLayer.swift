//
//  ImageGifNodeLayer.swift
//  ARKitImageRecognition
//
//  Created by Loris Pinna on 15/04/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ImageGifNodeLayer  :  CustomNodeLayer {
    var animation:(SCNNode)->() = {x in}
    
    
    override func createNode(parent: ARReferenceImage) -> SCNNode{
        
        let scene_plane = SCNPlane(width: parent.physicalSize.width,
                                   height: parent.physicalSize.height)
        
        let gifImageURL = Bundle.main.url(forResource: self.material_name, withExtension: "gif")
        let animation : CAKeyframeAnimation = createGIFAnimation(url: gifImageURL!)!
        
        
        
        let layer = CALayer()
        layer.bounds = CGRect(x: 00, y: 00, width: 1000, height: 1000)
        layer.anchorPoint = CGPoint(x:0.0,y:1.0)
        layer.add(animation, forKey: "contents")
        
        
        //Materiel
        let material = SCNMaterial();
        material.diffuse.contents = layer
        material.isDoubleSided = true
        scene_plane.firstMaterial?.isDoubleSided = true
        scene_plane.materials = [material];
        
        //Node
        let plane_node = SCNNode(geometry: scene_plane)
        plane_node.opacity = CGFloat(self.opacity);
        plane_node.position = self.position.getLayerPosition(parent: parent)
        plane_node.rotation = self.rotation
        
        plane_node.name = self.identifier
        
        plane_node.eulerAngles.x = -.pi / 2
        
        
        return plane_node
    }
    
    func createGIFAnimation(url:URL) -> CAKeyframeAnimation? { 
        guard let src = CGImageSourceCreateWithURL(url as CFURL, nil) else { return nil }
        let frameCount = CGImageSourceGetCount(src)
        
        // Total loop time
        var time : Float = 0
        
        // Arrays
        var framesArray = [AnyObject]()
        var tempTimesArray = [NSNumber]()
        
        // Loop
        for i in 0..<frameCount {
            
            // Frame default duration
            var frameDuration : Float = 0.1;
            
            let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(src, i, nil)
            guard let framePrpoerties = cfFrameProperties as? [String:AnyObject] else {return nil}
            guard let gifProperties = framePrpoerties[kCGImagePropertyGIFDictionary as String] as? [String:AnyObject]
                else { return nil }
            
            // Use kCGImagePropertyGIFUnclampedDelayTime or kCGImagePropertyGIFDelayTime
            if let delayTimeUnclampedProp = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber {
                frameDuration = delayTimeUnclampedProp.floatValue
            } else {
                if let delayTimeProp = gifProperties[kCGImagePropertyGIFDelayTime as String] as? NSNumber {
                    frameDuration = delayTimeProp.floatValue
                }
            }
            
            // Make sure its not too small
            if frameDuration < 0.011 {
                frameDuration = 0.100;
            }
            
            // Add frame to array of frames
            if let frame = CGImageSourceCreateImageAtIndex(src, i, nil) {
                tempTimesArray.append(NSNumber(value: frameDuration))
                framesArray.append(frame)
            }
            
            // Compile total loop time
            time = time + frameDuration
        }
        
        var timesArray = [NSNumber]()
        var base : Float = 0
        for duration in tempTimesArray {
            timesArray.append(NSNumber(value: base))
            base += ( duration.floatValue / time )
        }
        
        // From documentation of 'CAKeyframeAnimation':
        // the first value in the array must be 0.0 and the last value must be 1.0.
        // The array should have one more entry than appears in the values array.
        // For example, if there are two values, there should be three key times.
        timesArray.append(NSNumber(value: 1.0))
        
        // Create animation
        let animation = CAKeyframeAnimation(keyPath: "contents")
        
        animation.beginTime = AVCoreAnimationBeginTimeAtZero
        animation.duration = CFTimeInterval(time)
        animation.repeatCount = Float.greatestFiniteMagnitude;
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.values = framesArray
        animation.keyTimes = timesArray
        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.calculationMode = CAAnimationCalculationMode.discrete
        
        return animation;
    }
    
    
    func getIdentifier() -> String {
        return identifier;
    }
}
