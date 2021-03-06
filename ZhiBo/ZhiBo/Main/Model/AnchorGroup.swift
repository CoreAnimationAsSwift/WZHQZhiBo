//
//  AnchorGroup.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {
    var room_list :[[String:AnyObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }

    var icon_name:String = "home_header_normal"
    lazy var anchors :[AnchorModel] = [AnchorModel]()
    /*
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[String:AnyObject]] {
                for dict in dataArr {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    */
    
    
}
