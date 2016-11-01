//
//  CollectionHeaderView.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var iconName: UIImageView!
    
    var group : AnchorGroup? {
        didSet {
            labelView.text = group?.tag_name
            iconName.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
