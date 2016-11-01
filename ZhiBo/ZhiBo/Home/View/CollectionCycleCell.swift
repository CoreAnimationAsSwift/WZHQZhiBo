//
//  CollectionCycleCell.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var cycleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
//            guard let cycleModel = cycleModel else {return}
            cycleLabel.text = cycleModel?.title
            let url = NSURL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "Img_default"))
        }
    }
    
}
