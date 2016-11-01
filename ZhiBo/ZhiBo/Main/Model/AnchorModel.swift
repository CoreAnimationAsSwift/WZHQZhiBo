//
//  AnchorModel.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id :Int = 0
    var vertical_src :String = ""
    var isVertical : Int = 0
    var room_name :String = ""
    var nickname : String = ""
    var online : Int = 0
    var anchor_city : String = ""
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
