//
//  ChannelData.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit
enum ChannelName:String{
    case Red,Green,Blue
}

enum ChannelProperty:String {
    case Contrast, Brightness
    
    var defaultValue:CGFloat{
        get{
            switch self {
            case .Brightness:
                return 0
            case .Contrast:
                return 1
            }
        }
    }
    
    func getMinMaxValues()->(CGFloat, CGFloat){
        switch self {
        case .Brightness:
            return (-1, 1)
        case .Contrast:
            return (0.25, 4)
        }
    }
}

class ChannelColorFilterData: NSObject {
    var channelName:ChannelName
    var properties:[ChannelProperty:CGFloat] = [:]
    
     init(channelName:ChannelName) {
        self.channelName = channelName
    }
}
