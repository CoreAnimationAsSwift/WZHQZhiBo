//
//  BaseViewController.swift
//  ZhiBo
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
     lazy var imageView : UIImageView = {[unowned self] in
       let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    
}
extension BaseViewController {
    func setupUI() {
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        view.addSubview(imageView)
        imageView.startAnimating()
    }
    func stopAnimation() {
        imageView.stopAnimating()
        imageView.isHidden = true
        imageView.removeFromSuperview()
    }
}
