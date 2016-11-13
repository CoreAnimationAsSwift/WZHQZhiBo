//
//  AmuseViewModel.swift
//  ZhiBo
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class AmuseViewModel :BaseViewModel {

}

extension AmuseViewModel {
    func loadData(completion: @escaping ()->()) {
        loadDataBase(mothed: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) -> () in
            completion()
        }
    }
}
