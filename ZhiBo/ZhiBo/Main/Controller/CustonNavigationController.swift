//
//  CustonNavigationController.swift
//  ZhiBo
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CustonNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取手势
        guard let systemGes = self.interactivePopGestureRecognizer else {return}
        //获取手势的视图
        guard let gesView = systemGes.view else {return}
        //获取target/action
//        systemGes.addTarget(self, action: Selector(""))
        //运行时
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//        }
        let targsts = systemGes.value(forKey: "_targets") as! [AnyObject]
        guard let targestObjc = targsts.last else {return}
        guard let target = targestObjc.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
//        print(targestObjc)
//        Optional((action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fda5bc16da0>))
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
