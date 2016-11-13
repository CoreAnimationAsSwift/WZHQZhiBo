//
//  FunnyViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class FunnyViewModel:  BaseViewModel{
    func loadFunnyData(comption: @escaping() -> ()) {
        loadDataBase(isGroups: false, mothed: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit":30,"offset":0]) {
            comption()
        }
    }
}
