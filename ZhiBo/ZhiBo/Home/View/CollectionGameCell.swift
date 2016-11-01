//
//  CollectionGameCell.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let url = NSURL(string: group?.icon_url ?? "")
            imageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "home_more_btn"))
        }
    }
    
}
