//
//  UnitConverter.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 16/04/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation

class UnitConverter{
    static func pixelsToCentimeters(pixels:Int, dpi:Int = 96) -> Float {
        return Float(pixels) * (2.54 / Float(dpi))
    }
    static func centimetersToPixels(pixels:Int, dpi:Int = 96) -> Float {
        return Float(pixels) * ( 0.03937007  *  Float(dpi))
    }
}
