//
//  UIViewExtensions.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit

extension UIView{
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.frame = self.frame.offsetBy(dx:0,dy:movement)
        //self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
}
