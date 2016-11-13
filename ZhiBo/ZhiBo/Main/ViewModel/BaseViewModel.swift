//
//  BaseViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel {
    func loadDataBase(isGroups:Bool = true, mothed:MethodType,urlString:String,parameters:[String:Any]? = nil,completion:@escaping() ->()) {
        
        NetworkTools.requestData(mothed, urlString: urlString, parameters: parameters) {(response) -> ()in
            guard let data = response as? [String:Any] else {return}
            guard let dataArr = data["data"] as? [[String:Any]]else {return}
            if isGroups {
            for dict in dataArr {
               self.anchorGroups.append(AnchorGroup(dict:dict))
            }
            }else {
                let group = AnchorGroup()
                for dict in dataArr {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            completion()
        }
    }
}
