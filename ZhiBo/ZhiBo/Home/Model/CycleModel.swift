//
//  CycleModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title :String = ""
    var pic_url : String = ""
    var room : [String : AnyObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor : AnchorModel?
    init(dict:[String :AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
}
