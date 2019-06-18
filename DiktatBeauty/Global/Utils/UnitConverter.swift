//
//  UnitConverter.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation

class UnitConverter{
    /// Converts pixels to centimeters
    ///
    /// - Parameters:
    ///   - pixels: pixels value
    ///   - dpi: dpi value
    /// - Returns: value in centimeters
    static func pixelsToCentimeters(pixels: Int, dpi: Int = 96) -> Float {
        return Float(pixels) * (2.54 / Float(dpi))
    }
    
    /// Converts centimeters to pixels
    ///
    /// - Parameters:
    ///   - centimeters: centimeters value
    ///   - dpi: dpi value
    /// - Returns: value in pixels
    static func centimetersToPixels(centimeters: Int, dpi: Int = 96) -> Float {
        return Float(centimeters) * (0.03937007 * Float(dpi))
    }
}
