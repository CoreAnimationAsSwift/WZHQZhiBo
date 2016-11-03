//
//  UIBarBtuItem+extension.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String,highlightName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highlightName != "" {
        btn.setImage(UIImage(named: highlightName), for: .highlighted)
        }
        if size != CGSize.zero {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else {
            btn.sizeToFit()
        }
        self.init(customView:btn)
    }
}
