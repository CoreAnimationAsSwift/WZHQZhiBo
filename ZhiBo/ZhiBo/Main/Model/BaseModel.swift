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
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
