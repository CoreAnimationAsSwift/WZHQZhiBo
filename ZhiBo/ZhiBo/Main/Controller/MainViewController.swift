//
//  MainViewController.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC("Home")
        addChildVC("Follow")
        addChildVC("Live")
        addChildVC("Profile")
        
    }
    private func addChildVC(sbBord:String) {
        let vc = UIStoryboard(name: sbBord, bundle: nil).instantiateInitialViewController()
        addChildViewController(vc!)
        
    }
  
}
