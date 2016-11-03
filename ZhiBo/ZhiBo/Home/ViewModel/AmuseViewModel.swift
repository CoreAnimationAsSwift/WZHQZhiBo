//
//  AmuseViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var group :[AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadData(completion: @escaping ()->()) {
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {(resoponse) -> () in
            guard let data = resoponse as? [String:Any] else {return}
            guard let dataArr = data["data"] as? [[String :Any]] else {return}
//            print(dataArr)
            for dict in dataArr {
                self.group.append(AnchorGroup(dict: dict))
            }
            //回调
            completion()
        }
    }
}
