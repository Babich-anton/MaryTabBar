//
//  AppDelegate.swift
//  MaryTabBar
//
//  Created by Anton Babich on 14.07.2020.
//  Copyright © 2020 Anton Babich. All rights reserved.
//

import MaryTabBar
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        MaryTabBarSetting.initialPosition = 2
        MaryTabBarSetting.titleHidden = false
        MaryTabBarSetting.hideble = true
        MaryTabBarSetting.imageTintColor = .red
        MaryTabBarSetting.selectedImageTintColor = .orange
        MaryTabBarSetting.titleColor = .cyan
        MaryTabBarSetting.backgroundColor = .purple
        MaryTabBarSetting.circleTintColor = .lightGray
        
        return true
    }
}
