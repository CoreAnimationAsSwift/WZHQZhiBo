//
//  AppDelegate.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        return true
    }

    }

