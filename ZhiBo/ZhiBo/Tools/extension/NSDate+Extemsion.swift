//
//  NSDate+Extemsion.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation


extension Date {
    static func getCurrentTime() ->String {
        let nowDate = Date()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}
