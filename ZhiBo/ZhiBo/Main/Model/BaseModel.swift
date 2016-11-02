//
//  BaseModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var tag_name:String = ""
    var icon_url : String = ""
    override init() {
        
    }
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
