//
//  AppDelegate.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //keyboard lib
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = true
        return true
    }


}

