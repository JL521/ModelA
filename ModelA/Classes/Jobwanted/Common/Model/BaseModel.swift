//
//  BaseModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/6.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseModel<T:Mappable>: NSObject, Mappable{
    
    var code : String?
    var message : String?
    var result : T?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return BaseModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
        
    }
    
}
