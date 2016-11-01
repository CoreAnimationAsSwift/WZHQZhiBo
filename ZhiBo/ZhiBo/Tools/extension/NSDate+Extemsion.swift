//
//  NSDate+Extemsion.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation


extension NSDate {
    class func getCurrentTime() ->String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}