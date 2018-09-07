//
//  FloatExtensions.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit

public extension Float {
    /// random number extension
    public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}
