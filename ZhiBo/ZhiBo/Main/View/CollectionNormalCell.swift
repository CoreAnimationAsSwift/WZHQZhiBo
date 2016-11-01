//
//  CollectionNormalCell.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!
    override var anchor:AnchorModel? {
        
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
            
        }
    }
    
}
