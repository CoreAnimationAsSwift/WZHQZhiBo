//
//  ViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ViewModel {
    
    lazy var anchorGroup :[AnchorGroup] = [AnchorGroup]()
    private lazy var oneGroup :AnchorGroup = AnchorGroup()
    private lazy var twoGroup : AnchorGroup = AnchorGroup()
    
    func loadData(completion:() -> ()) {
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        let gcdGourp = dispatch_group_create()
        //1
        dispatch_group_enter(gcdGourp)
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) -> () in
            guard let resultDict = result as? [String:AnyObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else {return}
            self.oneGroup.tag_name = "热门"
            self.oneGroup.icon_name = "home_header_hot"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.oneGroup.anchors.append(anchor)
                
            }
            dispatch_group_leave(gcdGourp)
        }
        //2
        dispatch_group_enter(gcdGourp)
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) -> () in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String : AnyObject]] else {return}
            self.twoGroup.tag_name = "颜值"
            self.twoGroup.icon_name = "home_header_phone"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.twoGroup.anchors.append(anchor)
            }
            dispatch_group_leave(gcdGourp)
        }
        //3
        dispatch_group_enter(gcdGourp)
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) -> () in
            guard let resultDict = result as? [String:AnyObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else {return}
            for dict in dataArr {
                let group = AnchorGroup(dict:dict)
                self.anchorGroup.append(group)
            }
            dispatch_group_leave(gcdGourp)
        }
        dispatch_group_notify(gcdGourp, dispatch_get_main_queue()) { () -> Void in
            self.anchorGroup.insert(self.twoGroup, atIndex: 0)
            self.anchorGroup.insert(self.oneGroup, atIndex: 0)
            completion()
        }
    }
    
    
}
