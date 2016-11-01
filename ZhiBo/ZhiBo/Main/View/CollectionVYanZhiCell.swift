//
//  CollectionVYanZhiCell.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionVYanZhiCell: CollectionBaseCell {
    @IBOutlet weak var cityBtn: UIButton!
   override var anchor:AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, forState: .Normal)
        }
    }


}
