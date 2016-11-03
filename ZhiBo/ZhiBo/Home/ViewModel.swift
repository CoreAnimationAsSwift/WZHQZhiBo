//
//  ViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ViewModel {
    lazy var cycleModels :[CycleModel] = [CycleModel]()
    lazy var anchorGroup :[AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var oneGroup :AnchorGroup = AnchorGroup()
    fileprivate lazy var twoGroup : AnchorGroup = AnchorGroup()
    
    func loadData(_ completion:@escaping () -> ()) {
        let parameters = ["limit":"4","offset":"0","time":Date.getCurrentTime()]
        let gcdGourp = DispatchGroup()
        //1
        gcdGourp.enter()
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime()]) { (result) -> () in
            guard let resultDict = result as? [String:AnyObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else {return}
            self.oneGroup.tag_name = "热门"
            self.oneGroup.icon_name = "home_header_hot"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.oneGroup.anchors.append(anchor)
                
            }
            gcdGourp.leave()
        }
        //2
        gcdGourp.enter()
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) -> () in
            guard let resultDic = result as? [String : AnyObject] else {return}
            guard let dataArr = resultDic["data"] as? [[String : AnyObject]] else {return}
            self.twoGroup.tag_name = "颜值"
            self.twoGroup.icon_name = "home_header_phone"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.twoGroup.anchors.append(anchor)
            }
            gcdGourp.leave()
        }
        //3
        gcdGourp.enter()
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) -> () in
            guard let resultDict = result as? [String:AnyObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else {return}
            for dict in dataArr {
                let group = AnchorGroup(dict:dict)
                self.anchorGroup.append(group)
            }
            gcdGourp.leave()
        }
        gcdGourp.notify(queue: DispatchQueue.main) { () -> Void in
            self.anchorGroup.insert(self.twoGroup, at: 0)
            self.anchorGroup.insert(self.oneGroup, at: 0)
            completion()
        }
    }
    func loadCycleData(_ completion:@escaping () -> ()) {
        NetworkTools.requestData(.GET, urlString: "http://capi.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) -> () in
//            print(result)
            guard let resultDict = result as? [String : AnyObject] else {return}
            guard let resultArr = resultDict["data"] as? [[String:AnyObject]] else {return}
            
            for dict in resultArr {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            completion()
        }
    }
    
}
