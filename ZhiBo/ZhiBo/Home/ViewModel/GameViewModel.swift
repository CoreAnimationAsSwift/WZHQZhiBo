//
//  GameViewModel
//  ZhiBo
//
//  Created by mac on 16/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games :[GameModel] = [GameModel]()
}
extension GameViewModel {
    func loadData (_ completion:@escaping () -> ())  {
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) -> () in
            guard let dataDict = result as? [String : AnyObject] else {return}
            guard let dataArr = dataDict["data"] as? [[String :AnyObject]] else {return}
            for dict in dataArr {
                self.games.append(GameModel(dict: dict))
            }
            completion()
        }
    }
}
