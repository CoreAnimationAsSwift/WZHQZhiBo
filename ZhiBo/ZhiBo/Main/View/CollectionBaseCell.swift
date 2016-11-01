//
//  CollectionBaseCell.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onLineBtn: UIButton!
    var anchor:AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            guard let url = NSURL(string: anchor.vertical_src) else {return}
            iconImageView.kf_setImageWithURL(url)
            nickNameLabel.text = anchor.nickname
            var title : String = ""
            if anchor.online > 10000 {
                title = "\(Int(anchor.online / 10000))万人在线"
            }else {
                title = "\(anchor.online)人在线"
            }
            onLineBtn.setTitle(title, forState: .Normal)
            
        }
    }

    
}
