//
//  RecommendCyleView.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommendCyleView: UIView {

}
//MARK: - 快速创建类方法
extension RecommendCyleView {
    class func recommendCyleView() -> RecommendCyleView {
        let cyle = NSBundle.mainBundle().loadNibNamed("RecommendCyleView", owner: nil, options: nil).first as! RecommendCyleView
        return cyle
    }
}
