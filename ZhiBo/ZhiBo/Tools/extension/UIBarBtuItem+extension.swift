//
//  UIBarBtuItem+extension.swift
//  ZhiBo
//
//  Created by mac on 16/10/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String,highlightName:String = "",size:CGSize = CGSizeZero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highlightName != "" {
        btn.setImage(UIImage(named: highlightName), forState: .Highlighted)
        }
        if size != CGSizeZero {
        btn.frame = CGRect(origin: CGPointZero, size: size)
        }else {
            btn.sizeToFit()
        }
        self.init(customView:btn)
    }
}
