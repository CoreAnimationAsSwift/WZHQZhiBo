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
//            guard let url = URL(string: (cycleModel?.pic_url)!) else {
//                iconImageView.image = UIImage(named: "Img_default")
//                return
//            }
            
            if let url = URL(string: (cycleModel?.pic_url)!) {
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
            }else {
                 iconImageView.image = UIImage(named: "Img_default")
            }
        }
    }
    
}
