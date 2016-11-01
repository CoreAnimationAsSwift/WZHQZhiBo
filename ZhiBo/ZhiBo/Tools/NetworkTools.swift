//
//  NetworkTools.swift
//  ZhiBo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType :String {
    case GET = "GET"
    case POST = "POST"
}
class NetworkTools {
    class func requestData(type:MethodType,urlString:String,parameters:[String:AnyObject]? = nil,completion:(result:AnyObject?)->()) {
        
        if type == MethodType.GET {
          Alamofire.request(.GET, urlString).responseJSON(completionHandler: { (response) -> Void in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            completion(result: result)
          })
        }else {
        Alamofire.request(.POST, urlString,parameters: parameters).responseJSON(completionHandler: { (response) -> Void in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            completion(result: result)
        })
        }
    }
}
