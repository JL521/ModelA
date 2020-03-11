//
//  BaseArrayModel.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/12.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseArrayModel<T:Mappable>: NSObject, NSCoding, Mappable{
    var code : String?
    var message : String?
    var total : Int?
    var result : [T]?
    
    class func newInstance(map: Map) -> Mappable?{
        return BaseArrayModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        code <- map["code"]
        message <- map["message"]
        total <- map["total"]
        result <- map["result"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        result = aDecoder.decodeObject(forKey: "result") as? [T]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if result != nil{
            aCoder.encode(result, forKey: "result")
        }
        
    }
    
}
