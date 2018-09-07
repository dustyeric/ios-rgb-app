//
//  CustomFiltersVendor.swift
//  imageProcessingTest
//
//  Created by Dusty on 9/5/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit

class CustomFiltersVendor: NSObject , CIFilterConstructor{
    func filter(withName name: String) -> CIFilter? {
        switch name{
        case "RGBChannelCompositing":
            return RGBChannelCompositing()
        case "RGBChannelBrightnessAndContrast":
            return RGBChannelBrightnessAndContrast()
        default:
            return nil
        }
    }
}
