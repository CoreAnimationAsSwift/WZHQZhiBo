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
    class func requestData(_ type:MethodType,urlString:String,parameters:[String:Any]? = nil,completion:@escaping (_ result:Any?)->()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            completion(result)
        }
        
        }
}
